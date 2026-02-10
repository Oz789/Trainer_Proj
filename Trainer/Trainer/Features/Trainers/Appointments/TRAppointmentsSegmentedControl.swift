import SwiftUI

struct TRAppointmentsSegmentedControl<Segment: Identifiable & Hashable>: View where Segment.ID == String {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    private var t: ThemeTokens { themeManager.tokens(for: scheme) }

    @Binding var selection: Segment
    let segments: [Segment]

    private func label(for segment: Segment) -> String { segment.id
    }

    var body: some View {
        HStack(spacing: 8) {
            ForEach(segments) { s in
                Button {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
                        selection = s
                    }
                } label: {
                    Text(label(for: s))
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(selection == s ? t.titleColor : t.textSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(segmentBackground(isSelected: selection == s))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(6)
        .background(containerBackground)
    }

    private func segmentBackground(isSelected: Bool) -> some View {
        RoundedRectangle(cornerRadius: 14, style: .continuous)
            .fill(.white.opacity(isSelected ? (scheme == .dark ? 0.10 : 0.18) : 0.06))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(.white.opacity(isSelected ? 0.10 : 0.06), lineWidth: 1)
            )
    }

    private var containerBackground: some View {
        RoundedRectangle(cornerRadius: 18, style: .continuous)
            .fill(.black.opacity(scheme == .dark ? 0.18 : 0.06))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(.white.opacity(0.08), lineWidth: 1)
            )
    }
}
