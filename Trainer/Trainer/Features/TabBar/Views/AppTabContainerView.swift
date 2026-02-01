import SwiftUI

struct AppTabContainerView: View {
    let role: AppUserRoles

    @State private var selection: AppRoleTabs

    init(role: AppUserRoles) {
        self.role = role
        let first = TabConfig(role: role).tabs.first ?? .home
        _selection = State(initialValue: first)
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            // Main content
            tabContent
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.bottom, 92)

            // Bottom bar
            VStack {
                Spacer()
                TabBar(
                    tabs: TabConfig(role: role).tabs,
                    selection: $selection
                )
            }
        }
    }

    @ViewBuilder
    private var tabContent: some View {
        switch selection {
            
        case .profile:
           
            if role == .trainer {
                TrainerProfileMainView()
            } else {
                PlaceholderScreen(title: "Client Profile")
            }
            
        case .home:
            PlaceholderScreen(title: "Home")
            
        case .dashboard:
            PlaceholderScreen(title:"Dashboard")

        case .discover:
            PlaceholderScreen(title: "Discover")
            

        case .clients:
            PlaceholderScreen(title: "Clients")

        case .programs:
            PlaceholderScreen(title: "workout builder")

        case .workouts:
            PlaceholderScreen(title: "Workouts")


        }
    }
}

private struct PlaceholderScreen: View {
    let title: String
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white)
            Text("Replace this with your real view.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.6))
        }
    }
}

#Preview {
    AppTabContainerView(role: .trainer)
}

#Preview("Client") {
    AppTabContainerView(role: .client)
}
