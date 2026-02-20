#if DEBUG
import SwiftUI

struct DevThemeOverlay: View {
    let isDisabled: Bool
    @ObservedObject var themeManager: ThemeManager
    @Binding var themeIndex: Int

    var body: some View {
        DevThemeCycleButton(
            isSubmitting: isDisabled,
            themeManager: themeManager,
            themeIndex: $themeIndex
        )
    }
}
#endif
