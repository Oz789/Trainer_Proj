//NOT USED in MAIN VIEW As OF NOW
import SwiftUI

struct TProfileRails: View {
    let topTitle: String
    let bottomTitle: String
    let topItems: [TrainerRailItem]
    let bottomItems: [TrainerRailItem]

    var body: some View {
        VStack(spacing: 18) {
            TrainerHorizontalRail(title: topTitle, items: topItems)
            TrainerHorizontalRail(title: bottomTitle, items: bottomItems)
        }
        .padding(.top, 6)
    }
}

struct TrainerRailItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let subtitle: String

    static let mockTop: [TrainerRailItem] = [
        .init(icon: "figure.strengthtraining.traditional", title: "Morning HIIT Session", subtitle: "45 mins • 320 kcal"),
        .init(icon: "dumbbell.fill", title: "Upper Push Day", subtitle: "60 mins • 18 sets"),
        .init(icon: "figure.run", title: "Conditioning Run", subtitle: "25 mins • Zone 2")
    ]

    static let mockBottom: [TrainerRailItem] = [
        .init(icon: "trophy.fill", title: "Client Streak", subtitle: "12 weeks consistent"),
        .init(icon: "chart.line.uptrend.xyaxis", title: "Progress Highlights", subtitle: "Top transformations"),
        .init(icon: "star.fill", title: "Trainer Rating", subtitle: "4.9 avg • 200+")
    ]
}

struct TrainerHorizontalRail: View {
    let title: String
    let items: [TrainerRailItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(items) { item in
                        TrainerRailCard(item: item)
                    }
                }
                .padding(.horizontal, 2)
            }
        }
    }
}

struct TrainerRailCard: View {
    let item: TrainerRailItem

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: item.icon)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white.opacity(0.9))
                .frame(width: 36)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .lineLimit(2)

                Text(item.subtitle)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
                    .lineLimit(1)
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.35))
        }
        .padding(14)
        .frame(width: 320, height: 84)
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
