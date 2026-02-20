import SwiftUI

struct SignUpRoleButtons: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    private var themeToken: ThemeTokens { themeManager.tokens(for: scheme) }
    let onTrainer: () -> Void
    let onUser: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            roleButton(title: "Trainer", action: onTrainer)
            roleButton(title: "User", action: onUser)
        }
    }

    private func roleButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: 320)
                .frame(height: 54)
                .background(
                    LinearGradient(
                        colors: themeToken.ctaGradient,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .shadow(color: .black.opacity(0.35), radius: 14, x: 0, y: 10)
        }
    }
}

#Preview {
    SignUpRoleButtons(onTrainer: {}, onUser: {})
        .padding()
        .background(Color.black)
        .environmentObject(ThemeManager())
        .preferredColorScheme(.dark)
}
