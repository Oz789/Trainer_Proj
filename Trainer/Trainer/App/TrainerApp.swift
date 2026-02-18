import SwiftUI

@main
struct TrainerApp: App {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .environmentObject(session)
        }
    }
}
