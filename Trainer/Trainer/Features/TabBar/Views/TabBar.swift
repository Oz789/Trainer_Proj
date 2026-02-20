import SwiftUI

struct TabBar: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    @Binding var selection: AppRoleTabs
    private var t: ThemeTokens { themeManager.tokens(for: scheme) }
    let tabs: [AppRoleTabs]
    let center: AppRoleTabs?
    let onCenterTap: () -> Void

    var body: some View {
        ZStack(alignment: .bottom) {
            barBackground
            
            if let center {
                HStack(spacing: 0) {
                    ForEach(leftTabs(center: center), id: \.self) { tab in
                        tabButton(tab)
                    }
                    Color.clear.frame(width: 72)
                    
                    ForEach(rightTabs(center: center), id: \.self) { tab in
                        tabButton(tab)
                    }
                }
                .frame(height: 50)
                .padding(.bottom, 6)

                centerButton(center)
            } else {
                HStack(spacing: 0) {
                    ForEach(tabs, id: \.self) { tab in
                        tabButton(tab)
                    }
                }
                .frame(height: 50)
                .padding(.bottom, 6)
            }
        }
    }

    // MARK: - Layout and themes
    private func leftTabs(center: AppRoleTabs) -> [AppRoleTabs] {
        let others = tabs.filter { $0 != center }
        let mid = others.count / 2
        return Array(others.prefix(mid))
    }
    private func rightTabs(center: AppRoleTabs) -> [AppRoleTabs] {
        let others = tabs.filter { $0 != center }
        let mid = others.count / 2
        return Array(others.suffix(from: mid))
    }

    private var barBackground: some View {
        Rectangle()
            .fill(t.cardBackground.opacity(0.92))
            .frame(height: 80)
            .ignoresSafeArea(edges: .bottom)}

    private func tabButton(_ tab: AppRoleTabs) -> some View {
        Button {
            selection = tab
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.systemImage)
                    .font(.system(size: 18, weight: .semibold))
                Text(tab.title)
                    .font(.caption2)
            }
            .foregroundStyle(selection == tab ? .white : .white.opacity(0.45))
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)}

    private func centerButton(_ tab: AppRoleTabs) -> some View {
        Button(action: onCenterTap) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: t.ctaGradient,
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 62, height: 62)

                Image(systemName: tab.systemImage)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
        .offset(y: -26)}
}
