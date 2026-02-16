import SwiftUI

struct AuthCardContent: View {
    @Binding var email: String
    @Binding var password: String
    
    let isLoginMode: Bool
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
                    LoginFormSection(
                        email: $email,
                        password: $password,
                        isSubmitting: isSubmitting,
                        canSubmit: canSubmitLogin,
                        onLogin: onLogin
                    )
                    .disabled(isSubmitting)

                    Button(action: onForgotPassword) {
                        Text("Forgot password?")
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.75))
                    }
                    .disabled(isSubmitting || trimmedEmail.isEmpty)
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

