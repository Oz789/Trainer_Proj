import SwiftUI

struct MainTabContainerView: View {
    let role: AppUserRoles

    @State private var selection: AppRoleTabs
    @State private var paths: [AppRoleTabs: NavigationPath] = [:]

    private var centerTab: AppRoleTabs? {
        role == .trainer ? .profile : nil
    }


    init(role: AppUserRoles) {
        self.role = role
        let first = TabConfig(role: role).tabs.first ?? .home
        _selection = State(initialValue: first)
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ZStack {
                ForEach(availableTabs, id: \.self) { tab in
                    tabStack(for: tab)
                        .opacity(selection == tab ? 1 : 0)
                        .allowsHitTesting(selection == tab)
                }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            TabBar(
                tabs: availableTabs,
                selection: $selection,
                center: centerTab,
                onCenterTap: {
                    if let centerTab { selection = centerTab }
                }
            )
            .background(Color.black.ignoresSafeArea(edges: .bottom))
        }

    }

    private var availableTabs: [AppRoleTabs] {
        TabConfig(role: role).tabs
    }

    // MARK: - NavigationStack

    @ViewBuilder
    private func tabStack(for tab: AppRoleTabs) -> some View {
        NavigationStack(path: bindingPath(for: tab)) {
            rootView(for: tab)
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func bindingPath(for tab: AppRoleTabs) -> Binding<NavigationPath> {
        Binding(
            get: { paths[tab] ?? NavigationPath() },
            set: { paths[tab] = $0 }
        )
    }

    // MARK: - Root views

    @ViewBuilder
    private func rootView(for tab: AppRoleTabs) -> some View {
        switch tab {
        case .profile:
            if role == .trainer {
                TrainerProfileMainView()
            } else {
                UserProfileMainView()
            }

        case .home:
            PlaceholderScreen(title: "Home")

        case .appointments:
            TRMainAppointmentsView()

        case .dashboard:
            TRDashboardView()

        case .discover:
            PlaceholderScreen(title: "Discover")

        case .clients:
            TRMainClientsView()

        case .programs:
            PlaceholderScreen(title: "Workout Builder")

        case .workouts:
            PlaceholderScreen(title: "Workouts")
        }
    }
}

// MARK: - Placeholder 

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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

