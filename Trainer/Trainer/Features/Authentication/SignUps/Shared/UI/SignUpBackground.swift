import SwiftUI

struct SignUpBackground: View {
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        LinearGradient(
            colors: [Color.black, Color(white: 0.14)],
            startPoint: .top,
            endPoint: .bottom
        )
        .overlay(
            LinearGradient(
                colors: [Color.white.opacity(0.06), .clear, .black.opacity(0.25)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}
