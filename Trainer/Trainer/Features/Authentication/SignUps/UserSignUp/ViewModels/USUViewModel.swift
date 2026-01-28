import Foundation

@MainActor
final class UserSignUpViewModel: ObservableObject {

    enum Route: Hashable { case details, profile }

    enum Field: Hashable {
        case firstName, lastName, email, password
    }

    @Published var form = UserSignUpFormModel()
    @Published var path: [Route] = []

    @Published var isSubmitting: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""

    @Published private(set) var fieldErrors: [Field: String] = [:]

    var canContinue: Bool {
        validateBasic().isEmpty && !isSubmitting
    }

    func validateBasic() -> [Field: String] {
        var errors: [Field: String] = [:]

        if form.firstName.trimmed.isEmpty { errors[.firstName] = "First name is required." }
        if form.lastName.trimmed.isEmpty  { errors[.lastName]  = "Last name is required."  }

        let email = form.email.trimmed
        if email.isEmpty { errors[.email] = "Email is required." }
        else if !email.isValidEmail { errors[.email] = "Enter a valid email address." }

        let pw = form.password.trimmed
        if pw.isEmpty { errors[.password] = "Password is required." }
        else if pw.count < 6 { errors[.password] = "Password must be at least 6 characters." }

        return errors
    }

    func goToDetails() {
        fieldErrors = validateBasic()
        guard fieldErrors.isEmpty else { return }
        path.append(.details)
    }

    func finish() {
        fieldErrors = validateBasic()
        guard fieldErrors.isEmpty else { return }

        isSubmitting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.isSubmitting = false
            self.path.append(.profile)
        }
    }

    func backFromDetails() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
}

private extension String {
    var trimmed: String { trimmingCharacters(in: .whitespacesAndNewlines) }

    var isValidEmail: Bool {
        let pattern = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        return range(of: pattern, options: [.regularExpression, .caseInsensitive]) != nil
    }
}
