import SwiftUI

struct GreenTheme: AppThemeModel {
    let id = "theme.Green"
    let displayName = "Apple Green"

    private let accent = Color(hex: 0x4ADE80)
    private let accentDeep = Color(hex: 0x22C55E)
    private let greenWash = Color(hex: 0xDCFCE7)

    func tokens(for scheme: ColorScheme) -> ThemeTokens {
        switch scheme {

        // MARK: - Dark Mode
        case .dark:
            return ThemeTokens(
                backgroundGradient: [
                    Color.black,
                    Color.black.opacity(0.92),
                    accent.opacity(0.28)
                ],

                titleColor: .white,
                textPrimary: .white.opacity(0.92),
                textSecondary: .white.opacity(0.45),

                segmentedTint: .white.opacity(0.92),
                segmentedBackground: .clear,
                segmentedFill: Color.white.opacity(0.10),
                segmentedStroke: Color.white.opacity(0.18),
                segmentedSelectedFill: Color.white.opacity(0.18),
                segmentedSelectedStroke: accent.opacity(0.85),

                fieldFill: Color.white.opacity(0.08),
                fieldStroke: Color.white.opacity(0.16),
                fieldStrokeFocused: accent.opacity(0.95),
                fieldPlaceholder: Color.white.opacity(0.35),
                fieldText: Color.white.opacity(0.92),

                ctaGradient: [accent, accentDeep],
                accentGlow: accent.opacity(0.45),

                cardBackground: Color.white.opacity(0.06)
            )

        // MARK: - Light Mode
        default:
            return ThemeTokens(
                backgroundGradient: [.white,
                    greenWash.opacity(0.25),
                    accent.opacity(0.280)
                ],

                titleColor: .black,
                textPrimary: .black,
                textSecondary: .black.opacity(0.55),

                segmentedTint: .black,
                segmentedBackground: .clear,
                segmentedFill: .white,
                segmentedStroke: accent.opacity(0.55),
                segmentedSelectedFill: .white,
                segmentedSelectedStroke: accentDeep,

                fieldFill: .white,
                fieldStroke: accent.opacity(0.65),
                fieldStrokeFocused: accentDeep,
                fieldPlaceholder: .black.opacity(0.45),
                fieldText: .black,

                ctaGradient: [accent, accentDeep],
                accentGlow: accent.opacity(0.30),

                cardBackground: .white
            )
        }
    }
}

#Preview (){
    let tm = ThemeManager()
    tm.apply("theme.Green")

    let session = SessionManager()
    session.signOut()

    return ContentView()
        .environmentObject(tm)
        .environmentObject(session)
}
