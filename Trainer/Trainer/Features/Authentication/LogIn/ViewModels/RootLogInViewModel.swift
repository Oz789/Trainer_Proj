import SwiftUI

@MainActor
final class RootLogInViewModel: ObservableObject {
    @Published var isLoginMode: Bool = true
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showTrainerSignUp: Bool = false
    @Published var showUserSignUp: Bool = false
    @Published var isSubmitting: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    var trimmedEmail: String { email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }

    // MARK: - Actions

    func signIn(session: SessionManager) async {
        guard !isSubmitting else { return }

        guard trimmedEmail.contains("@"), password.count >= 6 else {
            presentAlert(
                title: "Check your info",
                message: "Enter a valid email and a password that’s at least 6 characters."
            )
            return
        }

        isSubmitting = true
        defer { isSubmitting = false }

        do {
            try await session.signIn(email: trimmedEmail, password: password)
        } catch {
            presentAlert(title: "Sign in failed", message: error.localizedDescription)
        }
    }

    func sendPasswordReset(session: SessionManager) async {
        guard !isSubmitting else { return }

        guard !trimmedEmail.isEmpty else {
            presentAlert(
                title: "Enter your email",
                message: "Type your email above, then tap “Forgot password?”."
            )
            return
        }

        isSubmitting = true
        defer { isSubmitting = false }

        do {
            try await session.sendPasswordReset(to: trimmedEmail)
            presentAlert(
                title: "Email sent",
                message: "If an account exists for \(trimmedEmail), you’ll receive a reset email shortly."
            )
        } catch {
            presentAlert(title: "Couldn’t send email", message: error.localizedDescription)
        }
    }

    private func presentAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
