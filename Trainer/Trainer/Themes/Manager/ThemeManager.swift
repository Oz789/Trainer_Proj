import SwiftUI

@MainActor
final class ThemeManager: ObservableObject {
    
//MARK: Variables for the class
    @AppStorage("activeThemeId") private var activeThemeId: String = "theme.Pink"
    @Published private(set) var theme: any AppThemeModel = PinkTheme()
    var allThemes: [any AppThemeModel] {
        [PinkTheme(), SkyBlueTheme(), BlueHorizonTheme(), EmberTheme(), CinderTheme()]
    }

    //MARK: Class initializer
    init() {
        apply(activeThemeId)
    }
    /// function for the initializer to run
    func apply(_ id: String) {
        activeThemeId = id
        switch id {
        case "theme.SkyBlue":
            theme = SkyBlueTheme()
        case "theme.BlueHoriz":
            theme = BlueHorizonTheme()
        case "theme.Ember":
            theme = EmberTheme()
        case "theme.Cinder":
            theme = CinderTheme()
        default:
            theme = PinkTheme()
        }
    }

    // MARK: public interface for retrieving theme tokens
    /// Returns the design tokens (colors, gradients, etc.)
    func tokens(for scheme: ColorScheme) -> ThemeTokens {
        theme.tokens(for: scheme)
    }
}
