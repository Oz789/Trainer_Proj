import SwiftUI

struct LogInButton: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    private var themeToken: ThemeTokens { themeManager.tokens(for: scheme) }
    let title: String
    var height: CGFloat = 54
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: 320)
                .frame(height: height)
                .background(
                    LinearGradient(colors: themeToken.ctaGradient, startPoint: .leading, endPoint: .trailing)
                )
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .shadow(color: .black.opacity(0.35), radius: 14, x: 0, y: 10)
        }
    }
}

#Preview {
    LogInButton(title: "Log In") {}
        .padding()
        .background(Color.black)
        .environmentObject(ThemeManager())
        .preferredColorScheme(.dark)
}
