import SwiftUI

struct TProfilePrograms: View {
    let title: String
    let programs: [TrainerProgramCard]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(programs) { p in
                        TrainerProgramCardView(program: p)
                    }
                }
                .padding(.horizontal, 2)
            }
        }
        .padding(.top, 8)
    }
}

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

struct TrainerProgramCardView: View {
    let program: TrainerProgramCard

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(program.badge.uppercased())
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.85))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(Color.white.opacity(0.08))
                    .clipShape(Capsule())

                Spacer()
            }

            Text(program.title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)
                .lineLimit(2)

            Text(program.subtitle)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.6))
                .lineLimit(1)

            Spacer(minLength: 0)
        }
        .padding(14)
        .frame(width: 220, height: 130)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(Color.white.opacity(0.10), lineWidth: 1)
                )
        )
    }
}
