import Foundation
import FirebaseAuth

@MainActor
final class TrainerSignUpViewModel: ObservableObject {

    enum Field: Hashable {
        case firstName, lastName, email, password
    }

    @Published var form = TrainerSignUpFormModel()
    @Published var isSubmitting: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published private(set) var fieldErrors: [Field: String] = [:]

    var canContinue: Bool {
        validate().isEmpty && !isSubmitting
    }

    func validate() -> [Field: String] {
        var errors: [Field: String] = [:]

        if form.firstName.trimmed.isEmpty { errors[.firstName] = "First name is required." }
        if form.lastName.trimmed.isEmpty { errors[.lastName] = "Last name is required." }

        let email = form.email.trimmed
        if email.isEmpty { errors[.email] = "Email is required." }
        else if !email.isValidEmail { errors[.email] = "Enter a valid email address." }

        let password = form.password.trimmed
        if password.isEmpty { errors[.password] = "Password is required." }
        else if password.count < 6 { errors[.password] = "Password must be at least 6 characters." }

        return errors
    }

    func submitTrainerSignUp(onSuccess: @escaping () -> Void) {
        fieldErrors = validate()
        guard fieldErrors.isEmpty else { return }

        isSubmitting = true
        Task {
            do {
                let email = form.email.trimmed.lowercased()
                let password = form.password.trimmed
                let uid = try await AuthService.shared.createUser(email: email, password: password)

                try await UserRepository.shared.createUserDoc(
                    uid: uid,
                    role: .trainer,
                    firstName: form.firstName.trimmed,
                    lastName: form.lastName.trimmed,
                    email: email
                )

                isSubmitting = false
                onSuccess()

            } catch {
                isSubmitting = false
                errorMessage = mapAuthError(error)
                showErrorAlert = true
            }
        }
    }

    private func mapAuthError(_ error: Error) -> String {
        let ns = error as NSError
        if ns.domain == AuthErrorDomain, let code = AuthErrorCode(rawValue: ns.code) {
            switch code {
            case .emailAlreadyInUse:
                return "That email is already in use. Try logging in instead."
            case .invalidEmail:
                return "That email address doesn’t look valid."
            case .weakPassword:
                return "Your password is too weak. Try at least 6+ characters."
            case .networkError:
                return "Network error. Check your connection and try again."
            default:
                return "Couldn’t create your account. Please try again."
            }
        }
        return "Something went wrong. Please try again."
    }
}
