import SwiftUI

struct BlueHorizonTheme: AppThemeModel {
    let id = "theme.BlueHorizon"
    let displayName = "Horizon"

    private let accent = Color(hex: 0x4B71AA)
    private let accentDeep = Color(hex: 0x0F356E)

    func tokens(for scheme: ColorScheme) -> ThemeTokens {
        switch scheme {

        case .dark:
            return ThemeTokens(
                backgroundGradient: [
                    Color(hex: 0x000000),
                    Color(hex: 0x010215),
                    Color(hex: 0x0F356E)
                ],

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
                accentGlow: accent.opacity(0.40),

                cardBackground: Color.white.opacity(0.06)
            )

        // MARK: - Light Mode
        default:
            return ThemeTokens(
                backgroundGradient: [
                    Color(hex: 0x000000),
                    Color(hex: 0x010215),
                    Color(hex: 0x0F356E),
                    Color(hex: 0x4B71AA),
                    Color(hex: 0xE2E8F2),
                    Color(hex: 0xFFFFFF)
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
