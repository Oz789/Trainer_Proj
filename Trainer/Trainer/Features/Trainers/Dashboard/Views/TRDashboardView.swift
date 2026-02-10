import SwiftUI

struct TRDashboardView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    @State private var overviewExpanded: Bool = true

    private var t: ThemeTokens { themeManager.tokens(for: scheme) }

    var body: some View {
        ZStack {
            LinearGradient(colors: t.backgroundGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 14) {
                header
                VStack(spacing: 12) {
                    TRDashboardFeedSection(posts: TRDashboardMockData.posts)
                        .frame(maxHeight: overviewExpanded ? 340 : .infinity, alignment: .top)

                    TRDashboardOverviewSection(
                        rows: TRDashboardMockData.overviewRows,
                        isExpanded: $overviewExpanded)
                }

            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 8)
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Dashboard")
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                    .foregroundStyle(t.titleColor)

                Text("Overview of your training business")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(t.textSecondary)
            }
            Spacer()
            Image(systemName: "bell.badge")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(t.textPrimary.opacity(0.9))
                .padding(10)
                .background(
                    Circle().fill(t.cardBackground)
                )
        }
        .padding(.top, 6)
    }
}

struct TRDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        TRDashboardView()
            .environmentObject(ThemeManager())
            .preferredColorScheme(.dark)
    }
}
