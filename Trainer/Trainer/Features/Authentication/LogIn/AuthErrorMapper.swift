import Foundation
import FirebaseAuth

enum AuthErrorMapper {
    static func displayInfo(for error: Error) -> (title: String, message: String) {
        let ns = error as NSError
        guard ns.domain == AuthErrorDomain,
              let code = AuthErrorCode(rawValue: ns.code) else {
            return ("Something went wrong", "Please try again.")
        }

        switch code {
        case .invalidEmail:
            return ("Invalid email", "Please enter a valid email address.")
        case .wrongPassword, .invalidCredential:
            return ("Incorrect login", "Your email or password is incorrect.")
        case .userNotFound:
            return ("Account not found", "No account exists for that email.")
        case .networkError:
            return ("No connection", "Check your internet connection and try again.")
        case .tooManyRequests:
            return ("Try again later", "Too many attempts. Please wait a bit and try again.")
        case .userDisabled:
            return ("Account disabled", "This account has been disabled. Contact support.")
        default:
            return ("Authentication failed", "Please try again.")
        }
    }
}


