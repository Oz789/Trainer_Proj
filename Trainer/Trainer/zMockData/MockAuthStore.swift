#if DEBUG
import Foundation
import Supabase

@MainActor
enum MockAuthStore {
    static let trainerId = UUID()
    static let user1Id = UUID()
    static let user2Id = UUID()
    static let user3Id = UUID()

    static let trainerProfile = Profile(
        id: trainerId,
        role: "trainer",
        username: "OzTrainer",
        createdAt: Date()
    )

    static let userProfiles: [Profile] = [
        Profile(id: user1Id, role: "client", username: "User1", createdAt: Date()),
        Profile(id: user2Id, role: "client", username: "User2", createdAt: Date()),
        Profile(id: user3Id, role: "client", username: "User3", createdAt: Date())
    ]

    static func makeSessionManagerTrainer() -> SessionManager {
        let session = SessionManager()
        session.isLoading = false
        session.profile = trainerProfile
        session.role = .trainer
        return session
    }

    static func makeSessionManagerUser(index: Int) -> SessionManager {
        let safeIndex = max(0, min(index, userProfiles.count - 1))
        let profile = userProfiles[safeIndex]
        let session = SessionManager()
        session.isLoading = false
        session.profile = profile
        session.role = .client
        return session
    }
}
#endif
