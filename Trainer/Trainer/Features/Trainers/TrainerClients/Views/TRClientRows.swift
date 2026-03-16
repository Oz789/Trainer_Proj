import SwiftUI

struct TRClientRows: View {
    let name: String
    let subtitle: String
    let showDivider: Bool

    @Environment(\.colorScheme) private var scheme

    private var iconBG: Color { scheme == .dark ? .white.opacity(0.10) : .black.opacity(0.06) }
    private var iconFG: Color { scheme == .dark ? .white.opacity(0.75) : .black.opacity(0.55) }
    private var dividerColor: Color { scheme == .dark ? .white.opacity(0.08) : .black.opacity(0.08) }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Circle()
                    .fill(iconBG)
                    .frame(width: 34, height: 34)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(iconFG)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text(name)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary)

                    Text(subtitle)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.secondary.opacity(0.7))
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 12)

            if showDivider {
                Divider()
                    .overlay(dividerColor)
                    .padding(.leading, 58)
            }
        }
    }
}
