import SwiftUI

struct TabsContainerView: View {
    @State private var selection: AppRoleTabs
    @State private var paths: [AppRoleTabs: NavigationPath] = [:]
    private var centerTab: AppRoleTabs? { role == .trainer ? .profile : nil }
    private var availableTabs: [AppRoleTabs] { TabConfig(role: role).tabs }
    let role: AppUserRoles
    
    init(role: AppUserRoles) {
        self.role = role
        let first = TabConfig(role: role).tabs.first ?? .home
        _selection = State(initialValue: first)
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
        //MARK: this makes it so EVERY tab is always LIVE but we can only see and touch the active tab (opacity/hitTesting)
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
                selection: $selection,
                tabs: availableTabs,
                center: centerTab,
                onCenterTap: {
                    if let centerTab { selection = centerTab }
                }
            )
            .background(Color.black.ignoresSafeArea(edges: .bottom))
        }

    }
    
    // MARK: - Root view for each tab
    @ViewBuilder
    private func rootView(for tab: AppRoleTabs) -> some View {
        
        switch tab {
            
        case .profile:
            if role == .trainer { TrainerProfileMainView()
            } else { UserProfileMainView() }
            
        case .home: PlaceholderScreen(title: "Home")
            
        case .appointments: TRMainAppointmentsView()
            
        case .dashboard:TRDashboardView()
            
        case .discover: TrainerDiscoverView(
                viewModel: TrainerDiscoverViewModel(service: TrainerConnectionService(client: supabase)))
            
        case .clients: TRMainClientsView()
            
        case .programs: PlaceholderScreen(title: "Workout Builder")
            
        case .workouts: PlaceholderScreen(title: "Workouts")
        }
    }
    
    // MARK: - NavigationStack for each individual tab to remain persistent
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
 }

// MARK: - Placeholder - delete later after all tabs have a real screen
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
