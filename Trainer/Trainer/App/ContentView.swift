import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        Group {
            if session.isLoggedIn, let role = session.role {
                switch role {
                case .trainer:
                    TrainerProfileMainView()
                case .client:
                    UserProfileMainView() 
                }
            } else {
                RootLogInView()
            }
        }
    }
}

#Preview {
    let tm = ThemeManager()
    tm.apply("theme.green")

    let session = SessionManager()
    session.signOut()

    return ContentView()
        .environmentObject(tm)
        .environmentObject(session)
}
