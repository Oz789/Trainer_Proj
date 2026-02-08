import SwiftUI

struct EmberTheme: AppThemeModel {
    let id = "theme.Ember"
    let displayName = "Ember"

    private let accent = Color(hex: 0xFF6A1A)
    private let accentDeep = Color(hex: 0xFF3D00)

    func tokens(for scheme: ColorScheme) -> ThemeTokens {
        switch scheme {
        case .dark:
            return ThemeTokens(
                backgroundGradient: [
                    Color.black,
                    Color.black.opacity(0.94),
                    accent.opacity(0.20)
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
                fieldStrokeFocused: accent.opacity(0.92),
                fieldPlaceholder: Color.white.opacity(0.35),
                fieldText: Color.white.opacity(0.92),

                ctaGradient: [accent, accentDeep],
                accentGlow: accent.opacity(0.45),
                cardBackground: Color.white.opacity(0.06)
            )

        default:
            return ThemeTokens(
                backgroundGradient: [
                    .white,
                    Color(hex: 0xF4F4F6),
                    Color(hex: 0xFFE6D6).opacity(0.55)
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
                fieldStroke: accent.opacity(0.60),
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
