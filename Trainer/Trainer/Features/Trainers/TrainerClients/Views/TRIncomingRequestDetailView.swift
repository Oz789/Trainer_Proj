import SwiftUI

@MainActor
struct TRIncomingRequestDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let request: TRIncomingRequestRow
    @StateObject private var vm: TRIncomingRequestDetailViewModel
    let onDecision: (() -> Void)?
    
    init(
        request: TRIncomingRequestRow,
        service: TrainerClientsServiceProtocol = SupabaseTrainerClientsService(client: supabase),
        onDecision: (() -> Void)? = nil
    ) {
        self.request = request
        self.onDecision = onDecision
        _vm = StateObject(wrappedValue: TRIncomingRequestDetailViewModel(service: service))
    }

    
    var body: some View {
        VStack(spacing: 14) {
            header
            
            detailsCard
            
            if let err = vm.errorMessage {
                Text(err)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            actionButtons
        }
        .padding(18)
        .navigationTitle("Request")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog(
            "Accept this client request?",
            isPresented: $vm.showAcceptConfirm,
            titleVisibility: .visible
        ) {
            Button("Accept", role: .none) {
                Task {
                    await vm.accept(requestId: request.id)
                    if vm.errorMessage == nil { onDecision?(); dismiss() }
                }
            }
            Button("Cancel", role: .cancel) { }
        }
        .sheet(isPresented: $vm.showDeclineSheet) {
            declineSheet
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(request.clientUsername)
                .font(.title3.weight(.semibold))
            Text("Status: \(request.status)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var detailsCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Request Details")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            Text("Goal: \(request.payload.goalPreset)")
            Text("Experience: \(request.payload.experience)")
            Text("Days/week: \(request.payload.availabilityDaysPerWeek)")
            Text("Equipment: \(request.payload.equipment)")
            
            if !request.payload.notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text("Notes: \(request.payload.notes)")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
        )
    }
    
    private var actionButtons: some View {
        HStack(spacing: 10) {
            Button {
                vm.showDeclineSheet = true
            } label: {
                Text(vm.isSubmitting ? "PLEASE WAIT…" : "DECLINE")
                    .font(.callout.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.bordered)
            .tint(.red)
            .disabled(vm.isSubmitting)
            
            Button {
                vm.showAcceptConfirm = true
            } label: {
                Text(vm.isSubmitting ? "PLEASE WAIT…" : "ACCEPT")
                    .font(.callout.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.isSubmitting)
        }
    }
    
    private var declineSheet: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Text("A reason is required.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("Reason for decline", text: $vm.declineReason, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...6)
                
                Spacer()
            }
            .padding(18)
            .navigationTitle("Decline Request")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { vm.showDeclineSheet = false }
                        .disabled(vm.isSubmitting)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Submit") {
                        Task {
                            await vm.decline(requestId: request.id)
                            if vm.errorMessage == nil {
                                vm.showDeclineSheet = false
                                onDecision?()
                                dismiss()
                            }
                        }
                    }
                    .disabled(!vm.canSubmitDecline)
                }
            }
        }
    }
}
