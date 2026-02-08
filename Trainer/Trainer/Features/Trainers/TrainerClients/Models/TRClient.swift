import Foundation

struct TRClient: Identifiable, Hashable {
    let id: UUID
    var name: String
    var handle: String
    var subtitle: String
    var score: Double
    var delta: Double
    var status: Status
    var avatarSystemImage: String

    enum Status: String, CaseIterable, Hashable {
        case active = "Active"
        case needsCheckIn = "Needs Check-in"
        case new = "New"
        case all = "All"
    }

    init(
        id: UUID = UUID(),
        name: String,
        handle: String,
        subtitle: String,
        score: Double,
        delta: Double,
        status: Status,
        avatarSystemImage: String = "person.fill"
    ) {
        self.id = id
        self.name = name
        self.handle = handle
        self.subtitle = subtitle
        self.score = score
        self.delta = delta
        self.status = status
        self.avatarSystemImage = avatarSystemImage
    }
}
