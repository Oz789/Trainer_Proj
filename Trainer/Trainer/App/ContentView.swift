import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        Group {
            if session.isLoading {
                ProgressView()
            } else if !session.isLoggedIn {
                RootLogInView()
            } else {
                AppTabContainerView(role: session.role ?? .trainer)
            }
        }
    }
}

#Preview {
    let tm = ThemeManager()
    tm.apply("theme.Cinder")

    let session = SessionManager() 
    return ContentView()
        .environmentObject(tm)
        .environmentObject(session)
}

