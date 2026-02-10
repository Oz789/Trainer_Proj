import SwiftUI

struct TRDashboardQuickRow: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    private var t: ThemeTokens { themeManager.tokens(for: scheme) }

    let row: TRDashboardOverviewRow

    var body: some View {
        Button {
        } label: {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(.white.opacity(0.08))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(.white.opacity(0.10), lineWidth: 1)
                        )

                    Image(systemName: row.systemImage)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                }
                .frame(width: 44, height: 44)

                VStack(alignment: .leading, spacing: 2) {
                    Text(row.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(t.textPrimary)

                    Text(row.subtitle)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(t.textSecondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.35))
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(t.cardBackground)
            )
        }
        .buttonStyle(.plain)
    }
}
