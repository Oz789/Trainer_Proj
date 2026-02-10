import SwiftUI

struct TRDashboardFeedSection: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    private var t: ThemeTokens { themeManager.tokens(for: scheme) }

    let posts: [TRDashboardPost]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Feed")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(t.textPrimary)

                Spacer()

                Text("Latest")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(t.textSecondary)
            }

            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(posts) { post in
                        TRDashboardPostCard(post: post)
                    }
                }
                .padding(.vertical, 2)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(t.cardBackground)
        )
    }
}

struct TRDashboardFeedSection_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            TRDashboardFeedSection(posts: TRDashboardMockData.posts)
                .environmentObject(ThemeManager())
                .padding()
        }
        .preferredColorScheme(.dark)
    }
}
