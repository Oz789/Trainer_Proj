import Foundation
import FirebaseAuth

@MainActor
final class SessionManager: ObservableObject {
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var isLoggedIn: Bool = false
    @Published private(set) var role: AppUserRoles?
    @Published private(set) var uid: String?

    private var authHandle: AuthStateDidChangeListenerHandle?

    init() {
        authHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self else { return }

            if let user {
                self.uid = user.uid
                self.isLoggedIn = true
                self.isLoading = true

                Task {
                    self.role = try? await UserRepository.shared.fetchRole(uid: user.uid)
                    self.isLoading = false
                }
            } else {
                self.uid = nil
                self.role = nil
                self.isLoggedIn = false
                self.isLoading = false
            }
        }
    }

    deinit {
        if let authHandle {
            Auth.auth().removeStateDidChangeListener(authHandle)
        }
    }

    func signOut() {
        try? AuthService.shared.signOut()
        // listener will update published state
    }
}
