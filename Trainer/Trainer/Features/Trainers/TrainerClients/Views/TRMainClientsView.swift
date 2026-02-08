import SwiftUI

@MainActor
struct TRMainClientsView: View {
    @State private var vm: TRMainClientsViewModel

    init() {
        _vm = State(initialValue: TRMainClientsViewModel(clients: TRClient.sample))
    }

    init(viewModel: TRMainClientsViewModel) {
        _vm = State(initialValue: viewModel)
    }

    var body: some View {
        ZStack {
            graphiteBackground.ignoresSafeArea()

            VStack(spacing: 14) {
                HStack {
                    Spacer()
                    Button {
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.8))
                            .frame(width: 34, height: 34)
                            .background(.white.opacity(0.06))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(.white.opacity(0.10), lineWidth: 1)
                            )
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 18)
                .padding(.top, 8)

                mainCard {
                    VStack(spacing: 12) {
                        Text("Clients")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.90))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom, 10)

                        TRClientsSearchBar(
                            text: $vm.searchText,
                            placeholder: "Search"
                        )
                        .opacity(0.95)
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
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(.white.opacity(0.04))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(.white.opacity(0.07), lineWidth: 1)
                        )


                        Button {
                            
                        } label: {
                            Text("SHOW MORE")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.white.opacity(0.65))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                        .buttonStyle(.plain)
                        .background(.white.opacity(0.03))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(.white.opacity(0.06), lineWidth: 1)
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

    // MARK: - Card Shell

    private func mainCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .background(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.08),
                                Color.white.opacity(0.05),
                                Color.white.opacity(0.035)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .stroke(.white.opacity(0.10), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.45), radius: 30, x: 0, y: 18)
    }

    // MARK: - Background

    private var graphiteBackground: some View {
        LinearGradient(
            colors: [
                Color.black,
                Color(red: 0.08, green: 0.08, blue: 0.09),
                Color(red: 0.06, green: 0.06, blue: 0.07)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct TRMainClientsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TRMainClientsView(viewModel: TRMainClientsViewModel(clients: TRClient.sample))
        }
        .preferredColorScheme(.dark)
    }
}
