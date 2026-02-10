import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        Group {
            if session.isLoading {
                ProgressView()
            } else if !session.isLoggedIn {
                RootLogInView()
            } else if let role = session.role {
                AppTabContainerView(role: role)
            } else {
                ProgressView("Finishing setup…")
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

