import SwiftUI

struct SettingsMainView: View {
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        List {
            Section("Appearance") {
                ThemePickerRow()
            }

            Section("About") {
                SettingsRow(title: "Version", value: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "—")
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let tm = ThemeManager()
    tm.apply("theme.green")
    return NavigationStack {
        SettingsMainView()
    }
    .environmentObject(tm)
    .preferredColorScheme(.dark)
}
