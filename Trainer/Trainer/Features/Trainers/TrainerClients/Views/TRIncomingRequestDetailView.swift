import SwiftUI

@MainActor
struct TRIncomingRequestDetailView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    @Environment(\.dismiss) private var dismiss
    let request: TRIncomingRequestRow
    @StateObject private var vm: TRIncomingRequestDetailViewModel
    let onDecision: (() -> Void)?

    private var t: ThemeTokens { themeManager.tokens(for: scheme) }
    private var titleColor: Color { scheme == .dark ? t.titleColor : .black }
    private var textSecondary: Color { scheme == .dark ? t.textSecondary : .black.opacity(0.55) }
    private var pillFill: Color { scheme == .dark ? t.segmentedFill : .black.opacity(0.06) }
    private var cardFill: Color { scheme == .dark ? t.cardBackground : .white }
    
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
        ZStack {
            LinearGradient(colors: t.backgroundGradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    header

                    profileCard
                    detailsCard
                    notesCard

                    if let err = vm.errorMessage {
                        Text(err)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    actionButtons
                }
                .padding(.horizontal, 18)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
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
        ZStack {
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(titleColor)
                        .frame(width: 32, height: 32)
                        .background(cardFill.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .buttonStyle(.plain)

                Spacer()
            }

            Text("Incoming Request")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(titleColor)
        }
    }

    private var profileCard: some View {
        infoCard {
            HStack(spacing: 14) {
                Circle()
                    .fill(scheme == .dark ? .white.opacity(0.12) : .black.opacity(0.08))
                    .frame(width: 54, height: 54)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(scheme == .dark ? .white.opacity(0.8) : .black.opacity(0.6))
                    )

                VStack(alignment: .leading, spacing: 6) {
                    Text(request.clientUsername)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(titleColor)

                    Text("@\(request.clientUsername.lowercased())")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(textSecondary)

                    Text("Requested \(formattedDate)")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(textSecondary)
                }

                Spacer()
            }
        }
    }

    private var detailsCard: some View {
        infoCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Request Details")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(textSecondary)

                infoRow(label: "Goal", value: goalDisplay)
                infoRow(label: "Experience", value: request.payload.experience.label)
                infoRow(label: "Days / Week", value: "\(request.payload.availabilityDaysPerWeek)")
                infoRow(label: "Equipment", value: request.payload.equipment.displayName)
                infoRow(label: "Timeframe", value: request.payload.timeframe.isEmpty ? "—" : request.payload.timeframe)
                infoRow(label: "Injuries", value: request.payload.injuries.isEmpty ? "None" : request.payload.injuries)
                infoRow(label: "Conditions", value: request.payload.conditions.isEmpty ? "None" : request.payload.conditions)
            }
        }
    }

    private var notesCard: some View {
        let notes = request.payload.notes.trimmingCharacters(in: .whitespacesAndNewlines)
        return Group {
            if !notes.isEmpty {
                infoCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notes")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(textSecondary)
                        Text(notes)
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
    
    private var actionButtons: some View {
        HStack(spacing: 10) {
            Button {
                vm.showDeclineSheet = true
            } label: {
                Text(vm.isSubmitting ? "PLEASE WAIT…" : "DECLINE")
                    .font(.callout.weight(.semibold))
                    .foregroundStyle(titleColor)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(pillFill)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(scheme == .dark ? .white.opacity(0.12) : .black.opacity(0.12), lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
            .disabled(vm.isSubmitting)
            
            Button {
                vm.showAcceptConfirm = true
            } label: {
                Text(vm.isSubmitting ? "PLEASE WAIT…" : "ACCEPT")
                    .font(.callout.weight(.semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(LinearGradient(colors: t.ctaGradient, startPoint: .leading, endPoint: .trailing))
                    )
            }
            .buttonStyle(.plain)
            .disabled(vm.isSubmitting)
        }
    }

    private var formattedDate: String {
        Self.dateFormatter.string(from: request.createdAt)
    }

    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()

    private var goalDisplay: String {
        if request.payload.goalPreset == .custom {
            let custom = request.payload.goalCustom?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            return custom.isEmpty ? "Custom" : custom
        }
        return request.payload.goalPreset.displayName
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text(label)
                .font(.caption.weight(.semibold))
                .foregroundStyle(textSecondary)
                .frame(width: 110, alignment: .leading)

            Text(value)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)

            Spacer(minLength: 0)
        }
    }

    private func infoCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(cardFill)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(scheme == .dark ? .white.opacity(0.08) : .black.opacity(0.08), lineWidth: 1)
            )
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
