import SwiftUI
import FirebaseCore

@main
struct TrainerApp: App {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var session = SessionManager()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .environmentObject(session)
        }
    }
}
