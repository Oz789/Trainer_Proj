import Foundation
import FirebaseFirestore

final class UserRepository {
    static let shared = UserRepository()
    private init() {}
    private let users = Firestore.firestore().collection("users")

    func createUserDoc(uid: String, role: AppUserRoles, firstName: String, lastName: String, email: String) async throws {
        try await users.document(uid).setData([
            "role": role.rawValue,
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "createdAt": FieldValue.serverTimestamp()
        ], merge: true)
    }
    func fetchRole(uid: String) async throws -> AppUserRoles? {
        let snap = try await users.document(uid).getDocument()
        let raw = snap.data()?["role"] as? String
        return raw.flatMap(AppUserRoles.init)
    }

    func listenUser(uid: String, onChange: @escaping (Result<AppUser?, Error>) -> Void) -> ListenerRegistration {
        users.document(uid).addSnapshotListener { snap, err in
            if let err {
                onChange(.failure(err))
                return
            }
            guard let snap, snap.exists else {
                onChange(.success(nil))
                return
            }
            
            let data = snap.data() ?? [:]
            let roleRaw = data["role"] as? String ?? ""
            let role = AppUserRoles(rawValue: roleRaw) ?? .client
            let firstName = (data["firstName"] as? String) ?? ""
            let lastName  = (data["lastName"] as? String) ?? ""
            let handle    = (data["handle"] as? String)
            let user = AppUser(
                id: uid,
                role: role,
                firstName: firstName,
                lastName: lastName,
                handle: handle
            )

            onChange(.success(user))
        }
    }
}
