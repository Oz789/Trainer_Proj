import SwiftUI

struct TabBar: View {
    let tabs: [AppRoleTabs]
    @Binding var selection: AppRoleTabs

    let center: AppRoleTabs
    let onCenterTap: () -> Void

    var body: some View {
        GeometryReader { proxy in
            let safeBottom = proxy.safeAreaInsets.bottom

            ZStack(alignment: .bottom) {
                barBackground
                    .frame(height: 64 + safeBottom)
                    .ignoresSafeArea(edges: .bottom)
                
                HStack(spacing: 0) {
                    ForEach(leftTabs, id: \.self) { tab in
                        tabButton(tab)
                    }
                    Color.clear
                        .frame(width: 78)

                    ForEach(rightTabs, id: \.self) { tab in
                        tabButton(tab)
                    }
                }
                .frame(height: 64)
                .padding(.bottom, safeBottom == 0 ? 8 : (safeBottom - 2))
                
                centerButton
                    .offset(y: -22) // tweak to move blue button only
            }
        }
        .frame(height: 50)
    }

    // MARK: - Logic Helpers

    private var leftTabs: [AppRoleTabs] {
        let filtered = tabs.filter { $0 != center }
        let mid = filtered.count / 2
        return Array(filtered.prefix(mid))
    }

    private var rightTabs: [AppRoleTabs] {
        let filtered = tabs.filter { $0 != center }
        let mid = filtered.count / 2
        return Array(filtered.suffix(from: mid))
    }

    // MARK: - Subviews

    private var barBackground: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.white.opacity(0.10))
                .frame(height: 0.2)
        }
    }

    private func tabButton(_ tab: AppRoleTabs) -> some View {
        Button {
            withAnimation(.spring(response: 0.28, dampingFraction: 0.85)) {
                selection = tab
            }
        } label: {
            VStack(spacing: 6) {
                Image(systemName: tab.systemImage)
                    .font(.system(size: 16, weight: .medium))

                Text(tab.title)
                    .font(.caption2.weight(.medium))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 02)
            .foregroundStyle(selection == tab ? .white : .white.opacity(0.45))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private var centerButton: some View {
        Button {
            onCenterTap()
        } label: {
            ZStack {
                Circle()
                    .fill( LinearGradient( colors: [Color.blue, Color.blue.opacity(0.55)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 38, height: 94)
                    .shadow(color: .blue.opacity(0.20), radius: 18, x: 0, y: 10)
                    .overlay( Circle() .stroke(.white.opacity(0.10), lineWidth: 1)
                    )

                Image(systemName: "rectangle")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview("Trainer") {
    AppTabContainerView(role: .trainer)
}

#Preview("Client") {
    AppTabContainerView(role: .client)
}
