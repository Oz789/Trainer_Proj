import SwiftUI

@MainActor
final class ThemeManager: ObservableObject {
    @AppStorage("activeThemeId") private var activeThemeId: String = "theme.pink"

    @Published private(set) var theme: AppTheme = PinkTheme()

    init() {
        apply(activeThemeId)
    }

    func apply(_ id: String) {
        activeThemeId = id
        switch id {
        case "theme.green": theme = GreenTheme()
        case "theme.blue": theme = BlueTheme()
        case "theme.white": theme = WhiteTheme()
        default: theme = PinkTheme()
        }
    }

    var allThemes: [AppTheme] {
        [GreenTheme(), PinkTheme(), BlueTheme(), WhiteTheme()]
    }
}
