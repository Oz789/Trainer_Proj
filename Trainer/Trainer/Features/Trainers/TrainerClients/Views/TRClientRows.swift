import SwiftUI

struct TRClientRows: View {
    let client: TRClient
    let showDivider: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {

                Circle()
                    .fill(.white.opacity(0.10))
                    .frame(width: 34, height: 34)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.75))
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text(client.name)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.90))

                    Text(client.handle)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.45))
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 3) {
                    Text(String(format: "%.1f", client.score))
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.92))

                    Text(String(format: "%@ %.1f",
                                client.delta >= 0 ? "▲" : "▼",
                                abs(client.delta)))
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.40))
                }
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 12)

            if showDivider {
                Divider()
                    .background(.white.opacity(0.08))
                    .padding(.leading, 58)
            }
        }
    }
}
