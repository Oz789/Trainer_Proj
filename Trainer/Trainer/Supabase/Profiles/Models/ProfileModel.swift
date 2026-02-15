import Foundation

struct Profile: Codable, Identifiable {
    let id: UUID
    let role: String
    let username: String?
    let createdAt: Date

    var displayName: String {
        let u = (username ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        return u.isEmpty ? "Trainer" : u
    }

    var handle: String {
        let u = (username ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        return u.isEmpty ? "@trainer" : "@\(u)"
    }

    enum CodingKeys: String, CodingKey {
        case id, role, username
        case createdAt = "created_at"
    }
}
