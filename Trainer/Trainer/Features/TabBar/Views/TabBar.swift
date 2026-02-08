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
                TabBarBackground()
                    .frame(height: 64 + safeBottom)
                    .ignoresSafeArea(edges: .bottom)

                HStack(spacing: 0) {
                    ForEach(leftTabs, id: \.self) { tab in
                        TabBarButtons(tab: tab, selection: $selection)
                    }

                    Color.clear
                        .frame(width: 78)

                    ForEach(rightTabs, id: \.self) { tab in
                        TabBarButtons(tab: tab, selection: $selection)
                    }
                }
                .frame(height: 64)
                .padding(.bottom, safeBottom == 0 ? 8 : (safeBottom - 2))

                TabCenterButton(onTap: onCenterTap)
                    .offset(y: -22)
            }
        }
        .frame(height: 50)
    }

    // MARK: - Logic

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
}
