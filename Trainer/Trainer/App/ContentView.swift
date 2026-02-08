
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        Group {
            if session.isLoggedIn, let role = session.role {
                AppTabContainerView(role: role)
            } else {
                RootLogInView()
            }
        }
    }
}

#Preview {
    let tm = ThemeManager()
    tm.apply("theme.Cinder")

    let session = SessionManager()
    session.signOut()

    return ContentView()
        .environmentObject(tm)
        .environmentObject(session)
}
