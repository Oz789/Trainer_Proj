import SwiftUI

struct TrainerRequestStepDetailsView: View {
    @Binding var form: TrainerRequestPayload
    @FocusState.Binding var focused: TrainerRequestThreeStepFormView.Field?

    var body: some View {
        VStack(spacing: 14) {
            TRInputField(placeholder: "Any injuries (e.g., none)", text: $form.injuries)
                .focused($focused, equals: .injuries)

            TRInputField(placeholder: "Any conditions (e.g., none)", text: $form.conditions)
                .focused($focused, equals: .conditions)

            VStack(alignment: .leading, spacing: 10) {
                Text("Availability")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)

                Stepper(value: $form.availabilityDaysPerWeek, in: 1...7) {
                    Text("\(form.availabilityDaysPerWeek) days / week")
                        .foregroundStyle(.white.opacity(0.85))
                }
                .tint(.white)
            }
            .trCardStyle()

            TRMenuPill(title: "Equipment: \(form.equipment.displayName)") {
                Picker("", selection: $form.equipment) {
                    ForEach(TrainerRequestPayload.Equipment.allCases, id: \.self) { eq in
                        Text(eq.displayName).tag(eq)
                    }
                }
            }

            TRTextArea(placeholder: "Extra notes for your trainer (optional)", text: $form.notes)
                .focused($focused, equals: .notes)
        }
    }
}

