import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        content
    }

    @ViewBuilder
    private var content: some View {
        if session.isLoading {
            ProgressView()

        } else if !session.isLoggedIn {
            RootLogInView()

        } else if let role = session.role {
            MainTabContainerView(role: role)

        } else {
            ProgressView("Finishing setup…")
                .task {
                    await session.refreshProfile()
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

