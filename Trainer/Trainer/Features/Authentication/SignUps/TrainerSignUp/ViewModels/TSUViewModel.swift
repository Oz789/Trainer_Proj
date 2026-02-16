import Foundation

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

    func submitTrainerSignUp(session: SessionManager, onSuccess: @escaping () -> Void) async {
        fieldErrors = validate()
        guard fieldErrors.isEmpty else { return }

        isSubmitting = true
        defer { isSubmitting = false }

        do {
            let email = form.email.trimmed.lowercased()
            let password = form.password.trimmed
            let username = makeUsername(first: form.firstName, last: form.lastName)

            try await session.signUp(
                email: email,
                password: password,
                role: "trainer",
                username: username
            )

            onSuccess()

        } catch {
 
            debugPrintSupabaseError(error, context: "Trainer Sign Up")

            errorMessage = userFacingSupabaseErrorMessage(from: error)

            showErrorAlert = true
        }
    }


    private func makeUsername(first: String, last: String) -> String {
        let f = first.trimmed.lowercased()
        let l = last.trimmed.lowercased()
        let raw = "\(f)\(l)"
        return raw.replacingOccurrences(of: " ", with: "")
    }

    private func mapSupabaseAuthError(_ error: Error) -> String {
        let msg = (error as NSError).localizedDescription.lowercased()
        if msg.contains("already") && msg.contains("registered") { return "That email is already in use. Try logging in instead." }
        if msg.contains("invalid") && msg.contains("email") { return "That email address doesn’t look valid." }
        if msg.contains("password") && (msg.contains("weak") || msg.contains("length")) { return "Your password is too weak. Try at least 6+ characters." }
        if msg.contains("network") || msg.contains("internet") { return "Network error. Check your connection and try again." }

        return "Couldn’t create your account. Please try again."
    }
}

//MARK: Debug functions

private func debugPrintSupabaseError(_ error: Error, context: String) {
    let ns = error as NSError
    print(" \(context) FAILED")
    print("Domain:", ns.domain)
    print("Code:", ns.code)
    print("Description:", ns.localizedDescription)
    print("UserInfo:", ns.userInfo)
}

private func userFacingSupabaseErrorMessage(from error: Error) -> String {
    let ns = error as NSError
    let message = ns.localizedDescription.trimmingCharacters(in: .whitespacesAndNewlines)

    if !message.isEmpty, message.lowercased() != "the operation couldn’t be completed." {
        return message
    }

    return "Sign up failed. Please try again."
}
