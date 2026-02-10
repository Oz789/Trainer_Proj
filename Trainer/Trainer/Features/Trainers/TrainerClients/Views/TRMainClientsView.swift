import SwiftUI

@MainActor
struct TRMainClientsView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    private var t: ThemeTokens { themeManager.tokens(for: scheme) }

    @State private var vm: TRMainClientsViewModel

    private let tabBarClearance: CGFloat = 92

    private var titleColor: Color { scheme == .dark ? t.titleColor : .black }
    private var textPrimary: Color { scheme == .dark ? t.textPrimary : .black.opacity(0.88) }
    private var textSecondary: Color { scheme == .dark ? t.textSecondary : .black.opacity(0.50) }
    private var pillFill: Color { scheme == .dark ? t.segmentedFill : .black.opacity(0.06) }
    private var cardFill: Color {
        scheme == .dark ? t.cardBackground : .white
    }

    init() {
        _vm = State(initialValue: TRMainClientsViewModel(clients: TRClient.sample))
    }

    init(viewModel: TRMainClientsViewModel) {
        _vm = State(initialValue: viewModel)
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

                Spacer()
            }
            .padding(.top, 10)
        }
        .navigationBarHidden(true)
    }

    private var header: some View {
        HStack {
            ProfileSettingsButton()
            Spacer()

            Button { } label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(textPrimary)
                    .frame(width: 34, height: 34)
                    .background(pillFill)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 18)
        .padding(.top, 8)
    }

    private var cardContent: some View {
        VStack(spacing: 12) {
            Text("Clients")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(titleColor)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 10)

            TRClientsSearchBar(text: $vm.searchText, placeholder: "Search")

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(vm.filteredClients.indices, id: \.self) { i in
                        let client = vm.filteredClients[i]
                        TRClientRows(client: client, showDivider: i < vm.filteredClients.count - 1)
                    }
                }
                .padding(.bottom, 6)
            }

            Button { } label: {
                Text("SHOW MORE")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(textSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.plain)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(pillFill)
            )
            .padding(.top, 6)
        }
    }
}
