import SwiftUI

@MainActor
final class ThemeManager: ObservableObject {
    @AppStorage("activeThemeId") private var activeThemeId: String = "theme.Pink"

    @Published private(set) var theme: any AppThemeModel = PinkTheme()

    init() {
        apply(activeThemeId)
    }

    func apply(_ id: String) {
        activeThemeId = id
        switch id {
        case "theme.SkyBlue":
            theme = SkyBlueTheme()
        case "theme.BlueHorizon":
            theme = BlueHorizonTheme()
        case "theme.Ember":
            theme = EmberTheme()
        case "theme.Cinder":
            theme = CinderTheme()
        default:
            theme = PinkTheme()
        }
    }

    var allThemes: [any AppThemeModel] {
        [PinkTheme(), SkyBlueTheme(), BlueHorizonTheme(), EmberTheme(), CinderTheme()]
    }

    func tokens(for scheme: ColorScheme) -> ThemeTokens {
        theme.tokens(for: scheme)
    }
}
