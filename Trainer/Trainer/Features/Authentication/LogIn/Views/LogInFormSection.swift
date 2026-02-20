import SwiftUI

struct LoginFormSection: View {
    @Binding var email: String
    @Binding var password: String
    let isSubmitting: Bool
    let canSubmit: Bool
    let onLogin: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            AuthTextField(text: $email, placeholder: "Email", isSecure: false)
            AuthTextField(text: $password, placeholder: "Password", isSecure: true)
            LogInButton(title: isSubmitting ? "Logging In..." : "Log In") {
                onLogin()
            }
            .padding(.top, 10)
            .disabled(!canSubmit)
            .opacity(canSubmit ? 1 : 0.55)
        }
    }
}
