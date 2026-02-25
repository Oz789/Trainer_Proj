import Foundation

struct TRIncomingRequestRow: Decodable, Identifiable, Equatable {
    let id: UUID
    let trainerId: UUID
    let clientId: UUID
    let status: String
    let payload: TrainerRequestPayload
    let createdAt: Date
    let clientUsername: String

    enum CodingKeys: String, CodingKey {
        case id
        case trainerId = "trainer_id"
        case clientId = "client_id"
        case status
        case payload
        case createdAt = "created_at"
        case clientUsername = "client_username"
    }
}
