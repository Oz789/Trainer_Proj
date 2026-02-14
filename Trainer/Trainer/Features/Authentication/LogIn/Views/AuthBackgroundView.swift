import SwiftUI

struct AuthBackgroundView: View {
    let themeToken: ThemeTokens

    var body: some View {
        LinearGradient(
            colors: themeToken.backgroundGradient,
            startPoint: UnitPoint(x: 0.5, y: 0.10),
            endPoint: UnitPoint(x: 0.5, y: 0.95)
        )
        .ignoresSafeArea()
    }
}

#Preview {
    let tm = ThemeManager()
    tm.apply("theme.Cinder")
    let token = tm.tokens(for: .dark)

    return AuthBackgroundView(themeToken: token)
        .preferredColorScheme(.dark)
}
