import SwiftUI

struct HorizonTheme: AppThemeModel {
    let id = "theme.Horizon"
    let displayName = "Horizon"

    func tokens(for scheme: ColorScheme) -> ThemeTokens {
        switch scheme {
        case .dark:
            return ThemeTokens(
                backgroundGradient: [
                    Color(hex: 0x000000),
                    Color(hex: 0x000000).opacity(0.94),
                    Color(hex: 0xA77456).opacity(0.22)
                ],

                titleColor: .white,
                textPrimary: Color.white.opacity(0.92),
                textSecondary: Color.white.opacity(0.45),

                segmentedTint: Color.white.opacity(0.92),
                segmentedBackground: .clear,
                segmentedFill: Color.white.opacity(0.10),
                segmentedStroke: Color.white.opacity(0.18),
                segmentedSelectedFill: Color.white.opacity(0.18),
                segmentedSelectedStroke: Color(hex: 0xC8A07A).opacity(0.85),

                fieldFill: Color.white.opacity(0.08),
                fieldStroke: Color.white.opacity(0.16),
                fieldStrokeFocused: Color(hex: 0xC8A07A).opacity(0.90),
                fieldPlaceholder: Color.white.opacity(0.35),
                fieldText: Color.white.opacity(0.92),

    
                ctaGradient: [
                    Color(hex: 0xC8A07A),
                    Color(hex: 0xA77456)
                ],
                accentGlow: Color(hex: 0xC8A07A).opacity(0.35),
                cardBackground: Color.white.opacity(0.06)
            )

        default:
            return ThemeTokens(
                backgroundGradient: [
                    .white,
                    .white,
                    Color(hex: 0xE7D2B8).opacity(0.35)
                ],

                titleColor: .black,
                textPrimary: Color(hex: 0x2B2622),
                textSecondary: Color(hex: 0x6E6258),

                segmentedTint: Color(hex: 0x2B2622),
                segmentedBackground: .clear,
                segmentedFill: .white,
                segmentedStroke: Color(hex: 0x8A7768).opacity(0.40),
                segmentedSelectedFill: .white,
                segmentedSelectedStroke: Color(hex: 0x8A7768),

                fieldFill: .white,
                fieldStroke: Color(hex: 0x8A7768).opacity(0.40),
                fieldStrokeFocused: Color(hex: 0x8A7768),
                fieldPlaceholder: Color(hex: 0x6E6258).opacity(0.60),
                fieldText: Color(hex: 0x2B2622),

                ctaGradient: [
                    Color(hex: 0xA77456),
                    Color(hex: 0xA77456)
                ],
                accentGlow: Color(hex: 0xA77456).opacity(0.25),
                cardBackground: .white
            )
        }
    }
}
