import Foundation

@MainActor
final class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool {
        didSet { UserDefaults.standard.set(isLoggedIn, forKey: Keys.isLoggedIn) }
    }

    @Published var role: AppUserRoles? {
        didSet { UserDefaults.standard.set(role?.rawValue, forKey: Keys.role) }
    }

    @Published var uid: String? {
        didSet { UserDefaults.standard.set(uid, forKey: Keys.uid) }
    }

    init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: Keys.isLoggedIn)

        if let raw = UserDefaults.standard.string(forKey: Keys.role),
           let parsed = AppUserRoles(rawValue: raw) {
            self.role = parsed
        } else {
            self.role = nil
        }

        self.uid = UserDefaults.standard.string(forKey: Keys.uid)
    }

    func signIn(role: AppUserRoles, uid: String? = nil) {
        self.role = role
        self.uid = uid
        self.isLoggedIn = true
    }

    func signOut() {
        self.isLoggedIn = false
        self.role = nil
        self.uid = nil
    }

    private enum Keys {
        static let isLoggedIn = "session.isLoggedIn"
        static let role = "session.role"
        static let uid = "session.uid"
    }
}
