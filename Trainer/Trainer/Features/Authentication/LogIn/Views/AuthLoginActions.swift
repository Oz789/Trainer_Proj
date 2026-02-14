import SwiftUI

struct AuthLoginActions: View {
    let isSubmitting: Bool
    let canSubmit: Bool
    let canReset: Bool

    let onLogin: () -> Void
    let onForgotPassword: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Button(action: onLogin) {
                ZStack {
                    if isSubmitting {
                        ProgressView()
                    } else {
                        Text("Log In")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.white.opacity(canSubmit ? 0.20 : 0.10))
                .foregroundColor(.white.opacity(canSubmit ? 1 : 0.55))
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .disabled(!canSubmit)

            Button(action: onForgotPassword) {
                Text("Forgot password?")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.75))
            }
            .disabled(isSubmitting || !canReset)
        }
    }
}

#Preview {
    AuthLoginActions(
        isSubmitting: false,
        canSubmit: true,
        canReset: true,
        onLogin: {},
        onForgotPassword: {}
    )
    .padding()
    .background(Color.black)
    .preferredColorScheme(.dark)
}
