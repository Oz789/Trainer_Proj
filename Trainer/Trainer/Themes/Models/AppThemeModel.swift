import SwiftUI

protocol AppThemeModel {
    var id: String { get }
    var displayName: String { get }
    func tokens(for scheme: ColorScheme) -> ThemeTokens
}
