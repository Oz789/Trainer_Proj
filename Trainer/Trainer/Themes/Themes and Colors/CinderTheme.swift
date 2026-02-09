import SwiftUI

struct CinderTheme: AppThemeModel {
    let id = "theme.Cinder"
    let displayName = "Cinder"

    private let accent = Color(hex: 0xFF6A00)
    private let accentDeep = Color(hex: 0xFF3D00)

    func tokens(for scheme: ColorScheme) -> ThemeTokens {
        switch scheme {
        case .dark:
            return ThemeTokens(

                backgroundGradient: [
                    Color(hex: 0x111214),
                    Color(hex: 0x151619),
                    Color(hex: 0x17181B)
                ],

                titleColor: .white.opacity(0.92),
                textPrimary: .white.opacity(0.90),
                textSecondary: .white.opacity(0.55),

                segmentedTint: .white.opacity(0.92),
                segmentedBackground: .clear,

                segmentedFill: Color(hex: 0x232427),
                segmentedStroke: Color.white.opacity(0.10),
                segmentedSelectedFill: Color(hex: 0x2A2B2F),
                segmentedSelectedStroke: accent.opacity(0.45),

                fieldFill: Color(hex: 0x1F2023),            
                fieldStroke: Color.white.opacity(0.14),
                fieldStrokeFocused: accent.opacity(0.55),
                fieldPlaceholder: .white.opacity(0.35),
                fieldText: .white.opacity(0.92),

                ctaGradient: [accent, accentDeep],
                accentGlow: accent.opacity(0.08),           
                cardBackground: Color(hex: 0x1B1C1F)
            )

        default:
            return ThemeTokens(
                backgroundGradient: [.white, .white],

                titleColor: .black,
                textPrimary: .black,
                textSecondary: .black.opacity(0.55),

                segmentedTint: .black,
                segmentedBackground: .clear,
                segmentedFill: Color(hex: 0xF2F2F4),
                segmentedStroke: Color.black.opacity(0.10),
                segmentedSelectedFill: Color(hex: 0xEEEEF1),
                segmentedSelectedStroke: accent.opacity(0.55),

                fieldFill: .white,
                fieldStroke: Color.black.opacity(0.12),
                fieldStrokeFocused: accent.opacity(0.65),
                fieldPlaceholder: .black.opacity(0.45),
                fieldText: .black,

                ctaGradient: [accent, accentDeep],
                accentGlow: accent.opacity(0.10),
                cardBackground: Color(hex: 0xF7F7F9)
            )
        }
    }
}
