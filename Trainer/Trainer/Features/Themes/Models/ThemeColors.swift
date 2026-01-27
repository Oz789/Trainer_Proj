import SwiftUI

struct GreenTheme: AppTheme {
    let id = "theme.green"
    let displayName = "Green"

    let backgroundGradient: [Color] = [
        .black,
        Color(red: 0.10, green: 0.12, blue: 0.10)
    ]

    let titleColor: Color = .white
    let textPrimary: Color = .white
    let textSecondary: Color = .white.opacity(0.45)

    let segmentedTint: Color = Color.green.opacity(0.35)
    let segmentedBackground: Color = Color.white.opacity(0.10)

    let fieldFill: Color = Color.white.opacity(0.10)
    let fieldStroke: Color = Color.white.opacity(0.18)

    let ctaGradient: [Color] = [Color.green, Color.white.opacity(0.75)]
}

struct PinkTheme: AppTheme {
    let id = "theme.pink"
    let displayName = "Pink"

    let backgroundGradient: [Color] = [
        .black,
        Color(red: 0.13, green: 0.10, blue: 0.13)
    ]

    let titleColor: Color = .white
    let textPrimary: Color = .white
    let textSecondary: Color = .white.opacity(0.45)

    let segmentedTint: Color = Color.pink.opacity(0.35)
    let segmentedBackground: Color = Color.white.opacity(0.10)

    let fieldFill: Color = Color.white.opacity(0.10)
    let fieldStroke: Color = Color.white.opacity(0.18)

    let ctaGradient: [Color] = [
        Color(red: 0.68, green: 0.32, blue: 0.98),
        Color(red: 1.00, green: 0.27, blue: 0.45)
    ]
}

struct BlueTheme: AppTheme {
    let id = "theme.blue"
    let displayName = "Blue"

    let backgroundGradient: [Color] = [
        .black,
        Color(red: 0.08, green: 0.10, blue: 0.14)
    ]

    let titleColor: Color = .white
    let textPrimary: Color = .white
    let textSecondary: Color = .white.opacity(0.45)

    let segmentedTint: Color = Color.blue.opacity(0.35)
    let segmentedBackground: Color = Color.white.opacity(0.10)

    let fieldFill: Color = Color.white.opacity(0.10)
    let fieldStroke: Color = Color.white.opacity(0.18)

    let ctaGradient: [Color] = [Color.blue, Color.cyan]
}

struct WhiteTheme: AppTheme {
    let id = "theme.white"
    let displayName = "White"

    let backgroundGradient: [Color] = [
        Color(red: 0.05, green: 0.05, blue: 0.06),
        Color(red: 0.16, green: 0.16, blue: 0.18)
    ]

    let titleColor: Color = .white
    let textPrimary: Color = .white
    let textSecondary: Color = .white.opacity(0.50)

    let segmentedTint: Color = Color.white.opacity(0.22)
    let segmentedBackground: Color = Color.white.opacity(0.10)

    let fieldFill: Color = Color.white.opacity(0.10)
    let fieldStroke: Color = Color.white.opacity(0.22)

    let ctaGradient: [Color] = [Color.white.opacity(0.85), Color.white.opacity(0.55)]
}
