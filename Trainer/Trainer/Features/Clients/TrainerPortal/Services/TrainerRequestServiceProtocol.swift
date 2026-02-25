import Foundation

protocol TrainerRequestServiceProtocol {
    func submitRequest(
        trainerId: UUID,
        payload: TrainerRequestPayload
    ) async throws
}
