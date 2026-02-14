import SwiftUI

struct AuthCardContent: View {
    let isLoginMode: Bool

    @Binding var email: String
    @Binding var password: String

    let isSubmitting: Bool

    let onLogin: () -> Void
    let onForgotPassword: () -> Void

    let onTrainerSignUp: () -> Void
    let onUserSignUp: () -> Void

    private var trimmedEmail: String {
        email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    private var canSubmitLogin: Bool {
        trimmedEmail.contains("@") && password.count >= 6 && !isSubmitting
    }

    var body: some View {
        Group {
            if isLoginMode {
                VStack(spacing: 12) {
                    LoginFormSection(email: $email, password: $password)
                        .disabled(isSubmitting)

                    AuthLoginActions(
                        isSubmitting: isSubmitting,
                        canSubmit: canSubmitLogin,
                        canReset: !trimmedEmail.isEmpty,
                        onLogin: onLogin,
                        onForgotPassword: onForgotPassword
                    )
                }
            } else {
                SignUpRoleSection(
                    onTrainer: onTrainerSignUp,
                    onUser: onUserSignUp
                )
                .disabled(isSubmitting)
            }
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.25), value: isLoginMode)
    }
}

#Preview {
    AuthCardContent(
        isLoginMode: true,
        email: .constant("test@email.com"),
        password: .constant("password"),
        isSubmitting: false,
        onLogin: {},
        onForgotPassword: {},
        onTrainerSignUp: {},
        onUserSignUp: {}
    )
    .padding()
    .background(Color.black)
    .preferredColorScheme(.dark)
}
