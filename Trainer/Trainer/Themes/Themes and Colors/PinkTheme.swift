import SwiftUI

struct PinkTheme: AppThemeModel {
    let id = "theme.Pink"
    let displayName = "Pink"

    private let accent = Color(hex: 0xFF4FD8)
    private let accentDeep = Color(hex: 0xFF2FAF)

    func tokens(for scheme: ColorScheme) -> ThemeTokens {
        switch scheme {
        case .dark:
            return ThemeTokens(
                backgroundGradient: [
                    Color.black,
                    Color.black.opacity(0.94),
                    accent.opacity(0.25)
                ],

                titleColor: .white,
                textPrimary: .white.opacity(0.92),
                textSecondary: .white.opacity(0.45),

                segmentedTint: .white.opacity(0.92),
                segmentedBackground: .clear,
                segmentedFill: Color.white.opacity(0.10),
                segmentedStroke: Color.white.opacity(0.18),
                segmentedSelectedFill: Color.white.opacity(0.18),
                segmentedSelectedStroke: accent.opacity(0.75),

                fieldFill: Color.white.opacity(0.08),
                fieldStroke: Color.white.opacity(0.16),
                fieldStrokeFocused: accent.opacity(0.85),
                fieldPlaceholder: Color.white.opacity(0.35),
                fieldText: Color.white.opacity(0.92),

                ctaGradient: [Color(hex: 0x9B5CFF), accent],
                accentGlow: accent.opacity(0.45),
                cardBackground: Color.white.opacity(0.06)
            )

        default:
            return ThemeTokens(
                backgroundGradient: [
                    .white,
                    .white,
                    accent.opacity(0.28)
                ],

                titleColor: .black,
                textPrimary: .black,
                textSecondary: .black.opacity(0.55),

                segmentedTint: .black,
                segmentedBackground: .clear,
                segmentedFill: .white,
                segmentedStroke: accent.opacity(0.55),
                segmentedSelectedFill: .white,
                segmentedSelectedStroke: accent,

                fieldFill: .white,
                fieldStroke: accent.opacity(0.55),
                fieldStrokeFocused: accent,
                fieldPlaceholder: .black.opacity(0.45),
                fieldText: .black,

                ctaGradient: [accent, accentDeep],
                accentGlow: accent.opacity(0.28),
                cardBackground: .white
            )
        }
    }
}
