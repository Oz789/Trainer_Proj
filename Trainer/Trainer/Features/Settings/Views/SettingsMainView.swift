import SwiftUI

struct SettingsMainView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var session: SessionManager

    @State private var showLogoutConfirm = false
    @State private var isLoggingOut = false
    @State private var logoutError: String?

    var body: some View {
        List {
            Section("Appearance") {
                ThemePickerRow()
            }
            Section("About") {
                SettingsRow(
                    title: "Version",
                    value: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "—"
                )
            }
            Section {
                Button(role: .destructive) {
                    showLogoutConfirm = true
                } label: {
                    if isLoggingOut {
                        HStack(spacing: 10) {
                            ProgressView()
                            Text("Logging Out…")
                        }
                    } else {
                        Text("Log Out")
                    }
                }
                .disabled(isLoggingOut)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Log Out?", isPresented: $showLogoutConfirm) {
            Button("Cancel", role: .cancel) { }
            Button("Log Out", role: .destructive) {
                Task { await logOut() }
            }
        } message: {
            Text("Are you sure you want to log out?")
        }
        .alert("Couldn’t log out", isPresented: Binding(
            get: { logoutError != nil },
            set: { if !$0 { logoutError = nil } }
        )) {
            Button("OK", role: .cancel) { logoutError = nil }
        } message: {
            Text(logoutError ?? "Unknown error.")
        }
    }

    @MainActor
    private func logOut() async {
        isLoggingOut = true
        defer { isLoggingOut = false }

        do {
            try await session.signOut()
        } catch {
            logoutError = error.localizedDescription
        }
    }
}
