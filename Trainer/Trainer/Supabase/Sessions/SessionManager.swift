import Foundation
import Supabase

@MainActor
final class SessionManager: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var session: Session? = nil
    @Published var role: AppUserRoles? = nil
    @Published var profile: Profile? = nil

    private let profileService = ProfileService()

    var isLoggedIn: Bool { session != nil }

    init() {
        Task { await loadInitial() }
    }

    private func loadInitial() async {
        defer { isLoading = false }
        session = try? await supabase.auth.session

        if session != nil {
            await refreshProfile()
        }
    }

    func refreshProfile() async {
        do {
            let p = try await profileService.fetchMyProfile()
            profile = p
            role = (p.role.lowercased() == "trainer") ? .trainer : .client
        } catch {
            profile = nil
            role = nil
        }
    }

    func signUp(email: String, password: String, role: String, username: String) async throws {
        _ = try await supabase.auth.signUp(
            email: email,
            password: password,
            data: [
                "role": .string(role),
                "username": .string(username)
            ]
        )
        session = try? await supabase.auth.session
        await refreshProfile()
    }

    func signIn(email: String, password: String) async throws {
        session = try await supabase.auth.signIn(email: email, password: password)
        await refreshProfile()
    }

    func signOut() async {
        try? await supabase.auth.signOut()
        session = nil
        role = nil
        profile = nil                                  
    }
}
