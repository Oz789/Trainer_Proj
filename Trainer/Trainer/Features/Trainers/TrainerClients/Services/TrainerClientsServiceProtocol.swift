import Foundation

protocol TrainerClientsServiceProtocol {
    func fetchIncomingRequests(trainerId: UUID) async throws -> [TRIncomingRequestRow]
    func fetchConnectedClients(trainerId: UUID, offset: Int, limit: Int) async throws -> [TRConnectedClient]
}
