import SwiftUI

@MainActor
struct TRMainClientsView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var session: SessionManager
    @Environment(\.colorScheme) private var scheme
    @StateObject private var vm: TRMainClientsViewModel

    private var t: ThemeTokens { themeManager.tokens(for: scheme) }
    private let tabBarClearance: CGFloat = 92
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
        Button { } label: {
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
            TRClientsSearchBar(text: $vm.searchText, placeholder: "Search")

            if let err = vm.errorMessage {
                Text(err)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 2)
            }

            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    pendingSection
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
        let list = vm.pendingFiltered
        if !list.isEmpty {
            sectionTitle("Pending")
            sectionCard {
                VStack(spacing: 0) {
                    ForEach(list) { req in
                        NavigationLink {
                            TRIncomingRequestDetailView(request: req) {
                                Task { await initialLoad() }
                            }
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

    // MARK: - Connected Section

    private var connectedSection: some View {
        VStack(spacing: 8) {
            sectionTitle("Connected")
                .padding(.top, vm.pendingFiltered.isEmpty ? 2 : 0)

            sectionCard {
                VStack(spacing: 0) {
                    let list = vm.connectedFiltered
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
}
