import FirebaseAuth
import FirebaseFirestore

final class FirebaseManager {
    static let shared = FirebaseManager()
    private init() {}

    let auth = Auth.auth()
    let db = Firestore.firestore()
}
