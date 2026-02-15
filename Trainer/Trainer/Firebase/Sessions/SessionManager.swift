import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class SessionManager: ObservableObject {
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var isLoggedIn: Bool = false
    @Published private(set) var role: AppUserRoles?
    @Published private(set) var uid: String?
    @Published private(set) var currentUser: AppUser?
    
    private var authHandle: AuthStateDidChangeListenerHandle?
    private var userListener: ListenerRegistration?
    init() {
        authHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self else { return }
            self.userListener?.remove()
            self.userListener = nil
            if let user {
                self.uid = user.uid
                self.isLoggedIn = true
                self.isLoading = true
                self.userListener = UserRepository.shared.listenUser(uid: user.uid) { [weak self] result in
                    guard let self else { return }
                    Task { @MainActor in
                        switch result {
                        case .success(let appUser):
                            self.currentUser = appUser
                            self.role = appUser?.role
                            self.isLoading = false
                        case .failure(let err):
                            print("User listener error:", err.localizedDescription)
                            self.currentUser = nil
                            self.isLoading = false
                        }
                    }
                }

            } else {
                self.uid = nil
                self.role = nil
                self.currentUser = nil
                self.isLoggedIn = false
                self.isLoading = false
            }
        }
    }

    deinit {
        if let authHandle { Auth.auth().removeStateDidChangeListener(authHandle) }
        userListener?.remove()
    }

    func signOut() {
        do { try AuthService.shared.signOut() }
        catch { print("Sign out failed:", error.localizedDescription) }
    }
}
