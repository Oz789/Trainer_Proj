import Foundation

@MainActor
final class TrainerSignUpViewModel: ObservableObject {

    enum Field: Hashable {
        case firstName, lastName, email, password
    }

    enum Route: Hashable {
        case profile
    }

    @Published var form = TrainerSignUpFormModel()
    @Published var isSubmitting: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published private(set) var fieldErrors: [Field: String] = [:]
    @Published var path: [Route] = []

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

    func validateAndContinue(onSuccess: @escaping () -> Void) {
        fieldErrors = validate()
        guard fieldErrors.isEmpty else { return }
        isSubmitting = true
        Task {
            try? await Task.sleep(nanoseconds: 350_000_000)
            isSubmitting = false
            onSuccess()
        }
    }
}

private extension String {
    var trimmed: String { trimmingCharacters(in: .whitespacesAndNewlines) }
    var isValidEmail: Bool {
        let pattern = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        return range(of: pattern, options: [.regularExpression, .caseInsensitive]) != nil
    }
}
