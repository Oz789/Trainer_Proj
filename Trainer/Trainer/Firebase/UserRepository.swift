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
}

