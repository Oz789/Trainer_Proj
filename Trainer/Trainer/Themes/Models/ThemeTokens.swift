import SwiftUI

enum ThemeSurfaceStyle: String, CaseIterable, Identifiable {
    case glass
    case matte

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .glass: return "Glass"
        case .matte: return "Matte"
        }
    }
}

struct ThemeTokens {
    var surfaceStyle: ThemeSurfaceStyle = .glass

    var backgroundGradient: [Color]

    var titleColor: Color
    var textPrimary: Color
    var textSecondary: Color

    var segmentedTint: Color
    var segmentedBackground: Color
    var segmentedFill: Color
    var segmentedStroke: Color
    var segmentedSelectedFill: Color
    var segmentedSelectedStroke: Color

    var fieldFill: Color
    var fieldStroke: Color
    var fieldStrokeFocused: Color
    var fieldPlaceholder: Color
    var fieldText: Color

    var ctaGradient: [Color]
    var accentGlow: Color
    var cardBackground: Color
}
