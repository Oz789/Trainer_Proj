import SwiftUI

struct ThemePickerRow: View {
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        NavigationLink {
            List {
                let themes = themeManager.allThemes

                ForEach(themes.indices, id: \.self) { i in
                    let theme = themes[i]

                    Button {
                        themeManager.apply(theme.id)
                    } label: {
                        HStack {
                            Text(theme.displayName)
                            Spacer()
                            if theme.id == themeManager.theme.id {
                                Image(systemName: "checkmark")
                                    .font(.body.weight(.semibold))
                            }
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
            .navigationTitle("Theme")
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            HStack {
                Text("Theme")
                Spacer()
                Text(themeManager.theme.displayName)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    let tm = ThemeManager()
    tm.apply("theme.blue")

    return NavigationStack {
        List {
            Section("Appearance") {
                ThemePickerRow()
            }
        }
    }
    .environmentObject(tm)
    .preferredColorScheme(.dark)
}
