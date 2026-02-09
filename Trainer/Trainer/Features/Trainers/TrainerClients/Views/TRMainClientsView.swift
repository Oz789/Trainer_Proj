import SwiftUI

@MainActor
struct TRMainClientsView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    private var t: ThemeTokens { themeManager.tokens(for: scheme) }

    @State private var vm: TRMainClientsViewModel

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
                HStack {
                    ProfileSettingsButton()
                    Spacer()

                    Button { } label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(t.textPrimary)
                            .frame(width: 34, height: 34)
                            .background(t.segmentedFill)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 18)
                .padding(.top, 8)

                mainCard {
                    VStack(spacing: 12) {
                        Text("Clients")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(t.titleColor)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom, 10)

                        TRClientsSearchBar(text: $vm.searchText, placeholder: "Search")

                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 0) {
                                ForEach(vm.filteredClients.indices, id: \.self) { i in
                                    let client = vm.filteredClients[i]
                                    TRClientRows(
                                        client: client,
                                        showDivider: i < vm.filteredClients.count - 1
                                    )
                                }
                            }
                        }

                        Button { } label: {
                            Text("SHOW MORE")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(t.textSecondary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                        .buttonStyle(.plain)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(t.segmentedFill)
                        )
                        .padding(.top, 6)
                    }
                    .padding(16)
                }
                .padding(.horizontal, 18)

                Spacer()
            }
            .padding(.top, 10)
        }
        .navigationBarHidden(true)
    }

    private func mainCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .background(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(t.cardBackground)
            )
            .shadow(color: .black.opacity(0.22), radius: 18, x: 0, y: 14)
    }
}

struct TRMainClientsView_Previews: PreviewProvider {
    static var previews: some View {
        let tm = ThemeManager()
        tm.apply("theme.Cinder") 
        return NavigationStack {
            TRMainClientsView(viewModel: TRMainClientsViewModel(clients: TRClient.sample))
        }
        .environmentObject(tm)
        .preferredColorScheme(.dark)
    }
}
