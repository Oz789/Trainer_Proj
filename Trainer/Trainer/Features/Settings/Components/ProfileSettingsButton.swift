import SwiftUI

struct ProfileSettingsButton: View {
    var body: some View {
        NavigationLink {
            SettingsMainView()
        } label: {
            Image(systemName: "gearshape")
                .foregroundStyle(.gray)
        }
        .accessibilityLabel("Settings")
    }
}

#Preview {
    let tm = ThemeManager()
    tm.apply("theme.green")
    return NavigationStack {
        ZStack {
            Color.black.ignoresSafeArea()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ProfileSettingsButton()
            }
        }
    }
    .environmentObject(tm)
}
