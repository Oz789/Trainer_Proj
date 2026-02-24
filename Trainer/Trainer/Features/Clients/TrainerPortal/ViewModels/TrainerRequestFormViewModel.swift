import Foundation

@MainActor
final class TrainerRequestFormViewModel: ObservableObject {
    @Published var payload: TrainerRequestPayload = .init()
    @Published var isSubmitting: Bool = false
    @Published var errorMessage: String? = nil
    @Published var didSubmit: Bool = false

    let trainer: TrainerPublic
    private let service: TrainerRequestServiceProtocol

    init(trainer: TrainerPublic, service: TrainerRequestServiceProtocol) {
        self.trainer = trainer
        self.service = service
    }

    var canSubmit: Bool {
        payload.canAdvanceFromBasics && !isSubmitting
    }

    func submit() async {
        guard canSubmit else { return }

        errorMessage = nil
        isSubmitting = true
        defer { isSubmitting = false }

        do {
            try await service.submitRequest(trainerId: trainer.id, payload: payload)
            didSubmit = true
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? "Request failed."
        }
    }
}
