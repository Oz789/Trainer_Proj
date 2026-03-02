import Foundation

@MainActor
final class TRIncomingRequestDetailViewModel: ObservableObject {
    enum SubmitState { case idle, submitting }
    
    @Published var submitState: SubmitState = .idle
    @Published var errorMessage: String? = nil
    @Published var showAcceptConfirm = false
    @Published var showDeclineSheet = false
    @Published var declineReason: String = ""
    private let service: TrainerClientsServiceProtocol
    
    init(service: TrainerClientsServiceProtocol) {
        self.service = service
    }
    
    var isSubmitting: Bool { submitState == .submitting }
    var canSubmitDecline: Bool {
        !declineReason.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isSubmitting
    }
    
    func accept(requestId: UUID) async {
        submitState = .submitting
        errorMessage = nil
        defer { submitState = .idle }
        
        do {
            try await service.acceptRequest(requestId: requestId)
        } catch { errorMessage = "Failed: \(error.localizedDescription)"}
}
    
    func decline(requestId: UUID) async {
        let reason = declineReason.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !reason.isEmpty else {
            errorMessage = "Please enter a reason."
            return
        }

        submitState = .submitting
        errorMessage = nil
        defer { submitState = .idle }

        do {
            try await service.declineRequest(requestId: requestId, reason: reason)
        } catch {
            errorMessage = "Failed to decline request."
        }
    }
    
    func beginAccept() {
        errorMessage = nil
        showAcceptConfirm = true
    }

    func beginDecline() {
        errorMessage = nil
        showDeclineSheet = true
    }


}
