import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class SessionManager: ObservableObject {

    @Published private(set) var isLoading: Bool = true
    @Published private(set) var isLoggedIn: Bool = false
    @Published private(set) var role: AppUserRoles?
    @Published private(set) var uid: String?

    private var authHandle: AuthStateDidChangeListenerHandle?

    init() {
        listenForAuthChanges()
    }

    deinit {
        if let authHandle {
            Auth.auth().removeStateDidChangeListener(authHandle)
        }
    }

    private func listenForAuthChanges() {
        authHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self else { return }

            if let user {
                self.uid = user.uid
                self.isLoggedIn = true
                self.isLoading = true
                self.loadUserRole(uid: user.uid)
            } else {
                self.clearSession()
                self.isLoading = false
            }
        }
    }

    private func loadUserRole(uid: String) {
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument { [weak self] snapshot, error in
                guard let self else { return }

                let rawRole = snapshot?.data()?["role"] as? String
                self.role = rawRole.flatMap(AppUserRoles.init)

                // Even if role is missing, we’re done loading session state
                self.isLoading = false
            }
    }

    func signOut() {
        try? Auth.auth().signOut()
        clearSession()
        isLoading = false
    }

    private func clearSession() {
        self.isLoggedIn = false
        self.role = nil
        self.uid = nil
    }
}
