import SwiftUI

struct MainAppView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if session.isLoading {
                ProgressView().tint(.white)
            } else if let role = session.role {
                MainTabContainerView(role: role)
                    .environmentObject(themeManager)
            } else if session.session == nil {
                RootLogInView()
                    .environmentObject(themeManager)
                    .environmentObject(session)
            } else {
                VStack(spacing: 10) {
                    Text("Couldn’t load your profile")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white)

                    Button("Try Again") {
                        Task { await session.refreshProfile() }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .task {
            if session.session != nil && session.profile == nil {
                await session.refreshProfile()
            }
        }
    }
}

#Preview("MainAppView (Client)") {
    let tm = ThemeManager()
    tm.apply("theme.Cinder")

    let sm = SessionManager()
    sm.isLoading = false
    sm.role = .client
    sm.profile = Profile(id: UUID(), role: "client", username: "ozClient", createdAt: Date())

    return MainAppView()
        .environmentObject(tm)
        .environmentObject(sm)
        .preferredColorScheme(.dark)
}



