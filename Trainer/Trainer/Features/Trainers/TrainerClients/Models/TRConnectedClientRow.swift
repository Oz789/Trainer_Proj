import Foundation

struct TRConnectedClient: Decodable, Identifiable, Equatable {
    let clientId: UUID
    let clientUsername: String

    var id: UUID { clientId }

    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case clientUsername = "client_username"
    }
}
