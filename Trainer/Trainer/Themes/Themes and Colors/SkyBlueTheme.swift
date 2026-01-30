import SwiftUI

struct SkyBlueTheme: AppThemeModel {
    let id = "theme.SkyBlue"
    let displayName = "Sky Blue"

    private let accent = Color(hex: 0x2EA7FF)
    private let accentDeep = Color(hex: 0x0A84FF)

    func tokens(for scheme: ColorScheme) -> ThemeTokens {
        switch scheme {
        case .dark:
            return ThemeTokens(
                backgroundGradient: [Color.black, Color.black.opacity(0.94), accent.opacity(0.22)],

                titleColor: .white,
                textPrimary: .white.opacity(0.92),
                textSecondary: .white.opacity(0.45),

                segmentedTint: .white.opacity(0.92),
                segmentedBackground: .clear,
                segmentedFill: Color.white.opacity(0.10),
                segmentedStroke: Color.white.opacity(0.18),
                segmentedSelectedFill: Color.white.opacity(0.18),
                segmentedSelectedStroke: accent.opacity(0.80),

                fieldFill: Color.white.opacity(0.08),
                fieldStroke: Color.white.opacity(0.16),
                fieldStrokeFocused: accent.opacity(0.90),
                fieldPlaceholder: Color.white.opacity(0.35),
                fieldText: Color.white.opacity(0.92),

                ctaGradient: [accent, accentDeep],
                accentGlow: accent.opacity(0.42),
                cardBackground: Color.white.opacity(0.06)
            )

        default:
            return ThemeTokens(
                backgroundGradient: [.white, .white, Color(hex: 0xBFE4FF).opacity(0.30)],

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
                fieldStroke: accent.opacity(0.55),
                fieldStrokeFocused: accentDeep,
                fieldPlaceholder: .black.opacity(0.45),
                fieldText: .black,

                ctaGradient: [accent, accentDeep],
                accentGlow: accent.opacity(0.25),
                cardBackground: .white
            )
        }
    }
}
