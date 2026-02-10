import SwiftUI

struct TRDashboardPostCard: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    private var t: ThemeTokens { themeManager.tokens(for: scheme) }

    let post: TRDashboardPost

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(.white.opacity(0.08))
                        .overlay(Circle().stroke(.white.opacity(0.10), lineWidth: 1))

                    Image(systemName: post.systemImage)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                }
                .frame(width: 34, height: 34)

                VStack(alignment: .leading, spacing: 2) {
                    Text(post.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(t.textPrimary)

                    Text(post.timestamp)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(t.textSecondary)
                }

                Spacer()

                if let badge = post.badge {
                    Text(badge)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.85))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(Capsule().fill(.white.opacity(0.10)))
                }
            }

            // body
            Text(post.body)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(t.textPrimary.opacity(0.85))
                .fixedSize(horizontal: false, vertical: true)

            // optional “highlight” strip for numeric posts
            if let highlight = post.highlight {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(highlight.value)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    Text(highlight.label)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.75))

                    Spacer()
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: t.ctaGradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: t.accentGlow.opacity(0.25), radius: 14, x: 0, y: 10)
                )
            }

            // actions (placeholders)
            HStack(spacing: 16) {
                action("View", "arrow.right.circle")
                action("Message", "bubble.left")
                action("More", "ellipsis")
                Spacer()
            }
            .padding(.top, 2)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .stroke(.white.opacity(0.08), lineWidth: 1)
                )
        )
    }

    private func action(_ title: String, _ systemImage: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: systemImage)
                .font(.system(size: 13, weight: .semibold))
            Text(title)
                .font(.system(size: 12, weight: .semibold))
        }
        .foregroundStyle(.white.opacity(0.75))
    }
}
