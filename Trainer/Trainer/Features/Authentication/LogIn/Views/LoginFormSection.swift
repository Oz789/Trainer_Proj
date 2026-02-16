import SwiftUI

struct LoginFormSection: View {
    @Binding var email: String
    @Binding var password: String

    let isSubmitting: Bool
    let canSubmit: Bool
    let onLogin: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            GlassField(placeholder: "Email", text: $email, isSecure: false)
            GlassField(placeholder: "Password", text: $password, isSecure: true)

            LogInCTAButton(title: isSubmitting ? "Logging In..." : "Log In") {
                onLogin()
            }
            .padding(.top, 10)
            .disabled(!canSubmit)
            .opacity(canSubmit ? 1 : 0.55)
        }
    }
}
