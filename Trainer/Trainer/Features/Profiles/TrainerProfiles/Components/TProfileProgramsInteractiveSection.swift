import SwiftUI

struct TProfileProgramsInteractiveSection: View {
    let title: String
    let programs: [TrainerProgramCard]
    let onSelect: (TrainerProgramCard) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)

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
    let program: TrainerProgramCard

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                // Badge / Tag (POPULAR / NEW)
                if let badge = program.badgeText { // <-- adjust to match your model
                    Text(badge.uppercased())
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.85))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(.white.opacity(0.10), in: Capsule())
                }

                Spacer()
            }

            Text(program.titleText) // <-- adjust to match your model
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)

            Text(program.subtitleText) // <-- adjust to match your model
                .font(.caption)
                .foregroundStyle(.white.opacity(0.65))

            Spacer(minLength: 0)
        }
        .padding(14)
        .frame(width: 230, height: 110)
        .background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(.white.opacity(0.08))
        )
    }
}


// MARK: - Adapter helpers (adjust to match your real model)

extension TrainerProgramCard {
    var titleText: String {
        // Replace with your real property (e.g. self.title)
        (Mirror(reflecting: self).children.first { $0.label == "title" }?.value as? String) ?? "Program"
    }

    var subtitleText: String {
        // Replace with your real property (e.g. "\(level) • \(daysPerWeek) days/wk")
        (Mirror(reflecting: self).children.first { $0.label == "subtitle" }?.value as? String) ?? "Intermediate • 4 days/wk"
    }

    var badgeText: String? {
        // Replace with your real property (e.g. self.badge)
        (Mirror(reflecting: self).children.first { $0.label == "badge" }?.value as? String)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        TProfileProgramsInteractiveSection(
            title: "Programs",
            programs: TrainerProgramCard.mock,
            onSelect: { _ in }
        )
        .padding()
    }
}
