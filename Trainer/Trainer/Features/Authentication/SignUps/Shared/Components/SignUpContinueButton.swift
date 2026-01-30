import SwiftUI

struct SignUpContinueButton: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme

    private var themeToken: ThemeTokens {
        themeManager.tokens(for: scheme)
    }


    let title: String
    var isLoading: Bool = false
    var isDisabled: Bool = false
    let action: () -> Void

    var body: some View {
        let theme = themeManager.theme
        let gradientColors = themeToken.ctaGradient
        let isDimmed = isDisabled || isLoading

        Button(action: action) {
            HStack(spacing: 10) {
                if isLoading {
                    ProgressView()
                        .tint(themeToken.textPrimary) // usually white
                }
                Text(title)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
        }
        .disabled(isDimmed)
        .background(
            LinearGradient(
                colors: gradientColors,
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .foregroundStyle(themeToken.textPrimary)
        .shadow(color: .black.opacity(0.35), radius: 10, y: 8)
        .opacity(isDimmed ? 0.7 : 1.0)
    }
}

