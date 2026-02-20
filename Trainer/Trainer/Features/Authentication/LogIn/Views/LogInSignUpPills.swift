import SwiftUI

struct LogInSignUpPills: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    @Binding var isLoginMode: Bool
    private var themeToken: ThemeTokens { themeManager.tokens(for: scheme)}

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

