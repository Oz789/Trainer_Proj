import SwiftUI

@MainActor
struct TRMainClientsView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var session: SessionManager
    @Environment(\.colorScheme) private var scheme
    @StateObject private var vm: TRMainClientsViewModel
    @State private var selectedRequest: TRIncomingRequestRow? = nil
    @State private var showFilters = false
    @State private var filters = TRClientsFilterState()

    private var t: ThemeTokens { themeManager.tokens(for: scheme) }
    private let tabBarClearance: CGFloat = 92
    private let pendingRowHeight: CGFloat = 62
    private var titleColor: Color { scheme == .dark ? t.titleColor : .black }
    private var textSecondary: Color { scheme == .dark ? t.textSecondary : .black.opacity(0.50) }
    private var pillFill: Color { scheme == .dark ? t.segmentedFill : .black.opacity(0.06) }
    private var cardFill: Color { scheme == .dark ? t.cardBackground : .white }

    init() {
        _vm = StateObject(
            wrappedValue: TRMainClientsViewModel(
                service: SupabaseTrainerClientsService(client: supabase)
            )
        )
    }

    init(viewModel: TRMainClientsViewModel) {
        _vm = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: t.backgroundGradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 14) {
                header

                pendingSection

                TRMainCard(fill: cardFill) {
                    cardContent
                }
                .padding(.horizontal, 18)
                .padding(.bottom, tabBarClearance)

                Spacer(minLength: 0)
            }
            .padding(.top, 10)
        }
        .navigationBarHidden(true)
        .task { await initialLoad() }
        .sheet(item: $selectedRequest) { req in
            TRIncomingRequestDetailView(request: req) {
                Task { await initialLoad() }
            }
            .environmentObject(themeManager)
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        .overlay {
            if showFilters {
                filterModalOverlay
            }
        }
    }

    private func initialLoad() async {
        guard let myId = session.session?.user.id else { return }
        await vm.load(trainerId: myId)
    }

    // MARK: - Header

    private var header: some View {
        ZStack {
            HStack {
                ProfileSettingsButton()
                Spacer()
                filterButton
            }

            Text("Clients")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(titleColor)
        }
        .padding(.horizontal, 18)
        .padding(.top, 8)
    }

    private var filterButton: some View {
        Button { showFilters = true } label: {
            Image(systemName: "slider.horizontal.3")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.primary)
                .frame(width: 34, height: 34)
                .background(pillFill)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    // MARK: - Card Content

    private var cardContent: some View {
        VStack(spacing: 12) {
            if let err = vm.errorMessage {
                Text(err)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 2)
            }

            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    connectedSection
                    showMoreSection
                }
                .padding(.bottom, 6)
                Text("DEBUG pending=\(vm.pending.count) filtered=\(vm.pendingFiltered.count) search='\(vm.searchText)'")
                    .font(.caption2)
                    .foregroundStyle(.yellow)
            }
        }
    }
    
    // MARK: - Pending Section

    @ViewBuilder
    private var pendingSection: some View {
        let list = vm.pending
        if !list.isEmpty {
            TRMainCard(fill: cardFill) {
                VStack(spacing: 12) {
                    sectionTitle("Pending")

                    if list.count > 3 {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 0) {
                                ForEach(list) { req in
                                    Button {
                                        selectedRequest = req
                                    } label: {
                                        TRClientRows(
                                            name: req.clientUsername,
                                            subtitle: "Tap to review request",
                                            showDivider: req.id != list.last?.id
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .frame(maxHeight: pendingRowHeight * 3)
                    } else {
                        VStack(spacing: 0) {
                            ForEach(list) { req in
                                Button {
                                    selectedRequest = req
                                } label: {
                                    TRClientRows(
                                        name: req.clientUsername,
                                        subtitle: "Tap to review request",
                                        showDivider: req.id != list.last?.id
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 18)
        }
    }

    // MARK: - Connected Section

    private var connectedSection: some View {
        VStack(spacing: 8) {
            sectionTitle("Connected")
                .padding(.top, vm.pending.isEmpty ? 2 : 0)

            TRClientsSearchBar(text: $vm.searchText, placeholder: "Search")

            sectionCard {
                VStack(spacing: 0) {
                    let list = sortedConnected(vm.connectedFiltered)
                    if list.isEmpty {
                        Text("No connected clients yet.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(14)
                    } else {
                        ForEach(list.indices, id: \.self) { i in
                            let c = list[i]
                            TRClientRows(
                                name: c.clientUsername,
                                subtitle: "@\(c.clientUsername)",
                                showDivider: i < list.count - 1
                            )
                        }
                    }
                }
            }
        }
    }

    // MARK: - Show More

    @ViewBuilder
    private var showMoreSection: some View {
        if vm.canShowMoreConnected, let myId = session.session?.user.id {
            Button {
                Task { await vm.loadMoreConnected(trainerId: myId) }
            } label: {
                Text(vm.isLoadingMore ? "LOADING…" : "SHOW MORE")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(textSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.plain)
            .disabled(vm.isLoadingMore)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(pillFill)
            )
            .padding(.top, 4)
        }
    }

    // MARK: - Helpers

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.caption.weight(.semibold))
            .foregroundStyle(textSecondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 2)
    }

    private func sectionCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(pillFill)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(scheme == .dark ? .white.opacity(0.08) : .black.opacity(0.08), lineWidth: 1)
            )
    }

    private func sortedConnected(_ list: [TRConnectedClient]) -> [TRConnectedClient] {
        switch filters.sort {
        case .az:
            return list.sorted { $0.clientUsername.localizedCaseInsensitiveCompare($1.clientUsername) == .orderedAscending }
        case .za:
            return list.sorted { $0.clientUsername.localizedCaseInsensitiveCompare($1.clientUsername) == .orderedDescending }
        }
    }

    private var filterModalOverlay: some View {
        ZStack {
            Color.black.opacity(0.45)
                .ignoresSafeArea()
                .onTapGesture { showFilters = false }

            TRClientsFilterSheet(filters: $filters)
                .environmentObject(themeManager)
                .frame(maxWidth: 380)
                .frame(maxHeight: 520)
                .background(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .fill(.ultraThinMaterial)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .stroke(scheme == .dark ? .white.opacity(0.12) : .black.opacity(0.12), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                .padding(.horizontal, 24)
                .transition(.scale.combined(with: .opacity))
        }
        .animation(.spring(response: 0.32, dampingFraction: 0.86), value: showFilters)
    }
}

#Preview("TRMainClientsView (Mock Trainer)") {
    let themeManager = ThemeManager()
    let session = MockAuthStore.makeSessionManagerTrainer()

    return NavigationStack {
        TRMainClientsView()
    }
    .environmentObject(themeManager)
    .environmentObject(session)
    
}
