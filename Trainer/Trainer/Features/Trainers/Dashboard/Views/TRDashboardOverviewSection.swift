import SwiftUI

struct TRDashboardOverviewSection: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    private var t: ThemeTokens { themeManager.tokens(for: scheme) }

    let rows: [TRDashboardOverviewRow]
    @Binding var isExpanded: Bool

    private var peekRows: ArraySlice<TRDashboardOverviewRow> {
        rows.prefix(2)
    }

    var body: some View {
        VStack(spacing: 0) {

            header
                .padding(.horizontal, 14)
                .padding(.top, 12)
                .padding(.bottom, isExpanded ? 10 : 6)

            if isExpanded {
                expandedList
                    .padding(.bottom, 8)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            } else {
                peekList
                    .padding(.bottom, 10)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(t.cardBackground)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(.white.opacity(0.06), lineWidth: 1)
        )
        .animation(.spring(response: 0.28, dampingFraction: 0.9), value: isExpanded)
    }

    // MARK: - Header

    private var header: some View {
        Button {
            withAnimation(.spring(response: 0.28, dampingFraction: 0.9)) {
                isExpanded.toggle()
            }
        } label: {
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Overview")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(t.textPrimary)

                    // subtle hint when collapsed
                    if !isExpanded {
                        Text("Quick access")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(t.textSecondary)
                    }
                }

                Spacer()

                // little "peek handle" feel
                Capsule()
                    .fill(.white.opacity(0.10))
                    .frame(width: 36, height: 5)
                    .opacity(isExpanded ? 0 : 1)
                    .padding(.trailing, 6)

                Text(isExpanded ? "Hide" : "Show")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(t.textSecondary)

                Image(systemName: "chevron.down")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(t.textSecondary)
                    .rotationEffect(.degrees(isExpanded ? 0 : -90))
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    // MARK: - Expanded list

    private var expandedList: some View {
        VStack(spacing: 0) {
            ForEach(rows.indices, id: \.self) { i in
                TRDashboardOverviewRowCell(row: rows[i])
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)

                if i != rows.indices.last {
                    Divider()
                        .overlay(.white.opacity(0.08))
                        .padding(.leading, 54)
                }
            }
        }
    }

    // MARK: - Peek list (when collapsed)

    private var peekList: some View {
        VStack(spacing: 8) {
            ForEach(peekRows) { row in
                peekRow(row)
            }

            HStack(spacing: 6) {
                Text("+ \(max(rows.count - 2, 0)) more")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(t.textSecondary)

                Spacer()

                Image(systemName: "arrow.up.right")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.35))
            }
            .padding(.horizontal, 14)
            .padding(.top, 2)
        }
        .padding(.horizontal, 10)
    }

    private func peekRow(_ row: TRDashboardOverviewRow) -> some View {
        HStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.white.opacity(0.04))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(.white.opacity(0.06), lineWidth: 1)
                    )

                Image(systemName: row.systemImage)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(t.textPrimary.opacity(0.85))
            }
            .frame(width: 32, height: 32)

            Text(row.title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(t.textPrimary.opacity(0.9))

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(.white.opacity(0.22))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.white.opacity(0.03))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(.white.opacity(0.05), lineWidth: 1)
                )
        )
    }
}

struct TRDashboardOverviewSection_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 12) {
                TRDashboardOverviewSection(
                    rows: TRDashboardMockData.overviewRows,
                    isExpanded: .constant(false)
                )
                TRDashboardOverviewSection(
                    rows: TRDashboardMockData.overviewRows,
                    isExpanded: .constant(true)
                )
            }
            .environmentObject(ThemeManager())
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}
