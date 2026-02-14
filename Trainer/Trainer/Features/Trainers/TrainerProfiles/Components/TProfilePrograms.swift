import SwiftUI

struct TrainerProgramCard: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let badge: String

    static let mock: [TrainerProgramCard] = [
        .init(title: "Hypertrophy 8-Week", subtitle: "Intermediate • 4 days/wk", badge: "Popular"),
        .init(title: "Cut & Conditioning", subtitle: "Beginner • 3 days/wk", badge: "New"),
        .init(title: "Strength Block", subtitle: "Advanced • 5 days/wk", badge: "Elite")
    ]
}

struct TProfileProgramsInteractiveSection: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme

    let title: String
    let programs: [TrainerProgramCard]
    let onSelect: (TrainerProgramCard) -> Void
    private var t: ThemeTokens { themeManager.tokens(for: scheme) }
    private var sectionTitleColor: Color {
        scheme == .dark ? t.titleColor : Color.black.opacity(0.88)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(sectionTitleColor)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(programs) { program in
                        Button {
                            onSelect(program)
                        } label: {
                            ProgramCardTile(program: program)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }
}

private struct ProgramCardTile: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme

    let program: TrainerProgramCard
    private var t: ThemeTokens { themeManager.tokens(for: scheme) }
    private var tileFill: Color {
        scheme == .dark ? Color.white.opacity(0.07) : Color.black.opacity(0.03)
    }
    private var tileStroke: Color {
        scheme == .dark ? Color.white.opacity(0.06) : Color.clear
    }
    private var badgeFill: Color {
        scheme == .dark ? Color.white.opacity(0.10) : Color.black.opacity(0.06)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(program.badge.uppercased())
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(t.textPrimary.opacity(0.80))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(badgeFill, in: Capsule())

                Spacer()
            }

            Text(program.title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(t.titleColor)
                .lineLimit(2)

            Text(program.subtitle)
                .font(.caption)
                .foregroundStyle(t.textPrimary.opacity(0.65))
                .lineLimit(1)

            Spacer(minLength: 0)
        }
        .padding(14)
        .frame(width: 230, height: 110)
        .background(tileFill, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(tileStroke, lineWidth: 1)
        )
        .shadow(
            color: Color.black.opacity(scheme == .dark ? 0.28 : 0.06),
            radius: scheme == .dark ? 14 : 10,
            x: 0, y: 10
        )
    }
}


#Preview("Programs Section") {
    let tm = ThemeManager()
    tm.apply("theme.green")

    return ZStack {
        Color.black.ignoresSafeArea()
        TProfileProgramsInteractiveSection(
            title: "Programs",
            programs: TrainerProgramCard.mock,
            onSelect: { _ in }
        )
        .padding()
    }
    .environmentObject(tm)
    .preferredColorScheme(.dark)
}
