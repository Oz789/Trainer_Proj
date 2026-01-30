import SwiftUI

struct LogInSegments: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme

    private var themeToken: ThemeTokens {
        themeManager.tokens(for: scheme)
    }

    @Binding var isLoginMode: Bool

    var body: some View {
        Picker("", selection: $isLoginMode) {
            Text("Log In").tag(true)
            Text("Sign Up").tag(false)
        }
        .pickerStyle(.segmented)
        .frame(maxWidth: 320)
        .tint(themeToken.segmentedTint)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(themeToken.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(themeToken.fieldStroke, lineWidth: 1.5)
                )
            )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    LogInSegments(isLoginMode: .constant(true))
        .padding()
        .background(Color.black)
        .environmentObject(ThemeManager())
        .preferredColorScheme(.dark)
}
