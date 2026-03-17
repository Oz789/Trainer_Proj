import SwiftUI

struct TRAppointmentsHeader: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    private var t: ThemeTokens { themeManager.tokens(for: scheme) }

    let title: String
    let subtitle: String
    let onTapNew: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                    .foregroundStyle(t.titleColor)

                Text(subtitle)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(t.textSecondary)
            }

            Spacer()

            Button(action: onTapNew) {
                HStack(spacing: 8) {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .semibold))
                    Text("New")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundStyle(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 14)
                .background(
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: t.ctaGradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: t.accentGlow.opacity(0.35), radius: 14, x: 0, y: 8)
                        .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 6)
                )
            }
            .buttonStyle(.plain)
        }
        .padding(.top, 6)
    }
}

struct TRAppointmentsHeader_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            TRAppointmentsHeader(
                title: "Appointments",
                subtitle: "Manage sessions, requests, and history",
                onTapNew: {}
            )
            .padding()
        }
        .environmentObject(ThemeManager())
        .preferredColorScheme(.dark)
    }
}
