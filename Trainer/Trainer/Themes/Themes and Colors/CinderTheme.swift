import SwiftUI

struct CinderTheme: AppThemeModel {
    let id = "theme.Cinder"
    let displayName = "Cinder"

    private let accent = Color(hex: 0xFF6A1A)
    private let accentDeep = Color(hex: 0xFF3D00)

    func tokens(for scheme: ColorScheme) -> ThemeTokens {
        switch scheme {

        case .dark:
            return ThemeTokens(
                backgroundGradient: [
                    Color(hex: 0x141416),
                    Color(hex: 0x1A1A1D),
                    Color(hex: 0x1A1A1D),
                    accent.opacity(0.08)],
                
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
                fieldStroke: Color.white.opacity(0.26),
                fieldStrokeFocused: accent.opacity(0.85),
                fieldPlaceholder: Color.white.opacity(0.35),
                fieldText: Color.white.opacity(0.92),

                ctaGradient: [accent, accentDeep],
                accentGlow: accent.opacity(0.45),
                cardBackground: Color.white.opacity(0.07)
            )

        default:
            return ThemeTokens(
                backgroundGradient: [
                    .white,
                    Color(hex: 0xF2F2F4),              
                    Color(hex: 0xFFE2D2).opacity(0.60)
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
