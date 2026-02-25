import SwiftUI

struct TrainerRequestStepBasicsView: View {
    @Binding var form: TrainerRequestPayload
    @Binding var ageText: String
    @Binding var feetText: String
    @Binding var inchesText: String
    @FocusState.Binding var focused: TrainerRequestThreeStepFormView.Field?

    var body: some View {
        VStack(spacing: 14) {
            HStack(spacing: 12) {
                TRInputField(placeholder: "Age", text: $ageText, keyboard: .numberPad)
                    .focused($focused, equals: .age)

                TRMenuPill(title: form.sex.display) {
                    Picker("", selection: $form.sex) {
                        ForEach(TrainerRequestPayload.Sex.allCases, id: \.self) { s in
                            Text(s.display).tag(s)
                        }
                    }
                }
            }

            HStack(spacing: 12) {
                TRInputField(placeholder: "Height (ft)", text: $feetText, keyboard: .numberPad)
                    .focused($focused, equals: .feet)

                TRInputField(placeholder: "in", text: $inchesText, keyboard: .numberPad)
                    .focused($focused, equals: .inches)
                    .frame(width: 110)
            }

            TRMenuPill(title: form.experience.label) {
                Picker("", selection: $form.experience) {
                    ForEach(TrainerRequestPayload.Experience.allCases, id: \.self) { exp in
                        Text(exp.label).tag(exp)
                    }
                }
            }

            TRMenuPill(title: form.goalPreset.displayName) {
                Picker("", selection: $form.goalPreset) {
                    ForEach(TrainerRequestPayload.GoalPreset.allCases, id: \.self) { g in
                        Text(g.displayName).tag(g)
                    }
                }
            }

            if form.goalPreset == .custom {
                TRInputField(
                    placeholder: "Custom goal (optional)",
                    text: Binding(
                        get: { form.goalCustom ?? "" },
                        set: { form.goalCustom = $0.isEmpty ? nil : $0 }
                    )
                )
                .focused($focused, equals: .goalCustom)
            }

            TRInputField(placeholder: "Timeframe (e.g., 8 weeks)", text: $form.timeframe)
                .focused($focused, equals: .timeframe)
        }
        .animation(.easeInOut(duration: 0.18), value: form.goalPreset)
    }
}

