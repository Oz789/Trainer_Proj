import SwiftUI

struct TRDashboardOverviewRowCell: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    private var t: ThemeTokens { themeManager.tokens(for: scheme) }

    let row: TRDashboardOverviewRow

    var body: some View {
        Button {
            // navigation later
        } label: {
            HStack(spacing: 10) {

                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white.opacity(0.05))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(.white.opacity(0.07), lineWidth: 1)
                        )

                    Image(systemName: row.systemImage)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(t.textPrimary.opacity(0.88))
                }
                .frame(width: 36, height: 36)

                VStack(alignment: .leading, spacing: 1) {
                    Text(row.title)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(t.textPrimary)

                    Text(row.subtitle)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(t.textSecondary)
                        .lineLimit(1)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.28))
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
