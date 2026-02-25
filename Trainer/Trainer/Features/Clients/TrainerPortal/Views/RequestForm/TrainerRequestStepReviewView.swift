import SwiftUI

struct TrainerRequestStepReviewView: View {
    let form: TrainerRequestPayload

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Review your info")
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)

            VStack(alignment: .leading, spacing: 10) {
                row("Age", value: form.age.map(String.init) ?? "—")
                row("Sex", value: form.sex.display)
                row("Height", value: heightString)

                Divider().opacity(0.25)

                row("Experience", value: form.experience.label)
                row("Goal", value: goalString)
                row("Timeframe", value: form.timeframe.isEmpty ? "—" : form.timeframe)

                Divider().opacity(0.25)

                row("Injuries", value: form.injuries.isEmpty ? "—" : form.injuries)
                row("Conditions", value: form.conditions.isEmpty ? "—" : form.conditions)

                Divider().opacity(0.25)

                row("Availability", value: "\(form.availabilityDaysPerWeek) days / week")
                row("Equipment", value: form.equipment.displayName)
                row("Notes", value: form.notes.isEmpty ? "—" : form.notes)
            }
            .trCardStyle()

            Text("Tap Back to edit anything before submitting.")
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.70))
        }
    }

    private var heightString: String {
        let ft = form.heightFeet
        let inch = form.heightInches

        if ft == nil && inch == nil { return "—" }

        let ftPart = ft.map { "\($0) ft" } ?? ""
        let inPart = inch.map { "\($0) in" } ?? ""

        let combined = [ftPart, inPart].filter { !$0.isEmpty }.joined(separator: " ")
        return combined.isEmpty ? "—" : combined
    }

    private var goalString: String {
        if form.goalPreset == .custom {
            return (form.goalCustom?.isEmpty == false) ? form.goalCustom! : "Custom"
        } else {
            return form.goalPreset.displayName
        }
    }

    private func row(_ title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.92))
                .frame(width: 110, alignment: .leading)

            Text(value)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.80))

            Spacer(minLength: 0)
        }
    }
}

#Preview {
    let sample = TrainerRequestPayload(
        age: 24,
        sex: .male,
        heightFeet: 5,
        heightInches: 10,
        experience: .beginner,
        goalPreset: .hypertrophy,
        goalCustom: nil,
        timeframe: "8 weeks",
        injuries: "None",
        conditions: "None",
        availabilityDaysPerWeek: 4,
        equipment: .gym,
        notes: "I want to focus on chest + legs."
    )

    return ZStack {
        Color.black.ignoresSafeArea()
        TrainerRequestStepReviewView(form: sample)
            .padding()
    }
    .preferredColorScheme(.dark)
}
