//This file will be deleted
import SwiftUI

struct DevThemeCycleButton: View {
    let isSubmitting: Bool
    let themeManager: ThemeManager
    @Binding var themeIndex: Int

    var body: some View {
        VStack {
            HStack {
                Button("NEXT THEME") {
                    let themes = themeManager.allThemes
                    guard !themes.isEmpty else { return }
                    themeIndex = (themeIndex + 1) % themes.count
                    themeManager.apply(themes[themeIndex].id)
                }
                .padding(10)
                .background(Color.black.opacity(0.6))
                .foregroundColor(.white)
                .disabled(isSubmitting)

                Spacer()
            }
            .padding(.top, 12)
            .padding(.leading, 12)

            Spacer()
        }
    }
}

#Preview {
    let tm = ThemeManager()
    tm.apply("theme.Cinder")
    return DevThemeCycleButton(isSubmitting: false, themeManager: tm, themeIndex: .constant(0))
        .preferredColorScheme(.dark)
}
