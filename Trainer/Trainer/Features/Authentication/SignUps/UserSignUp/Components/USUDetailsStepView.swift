import SwiftUI

struct UserSignUpDetailsStepView: View {
    @Binding var form: UserSignUpFormModel

    let isSubmitting: Bool
    let onBack: () -> Void
    let onFinish: () -> Void

    var body: some View {
        VStack(spacing: 18) {
            VStack(spacing: 10) {
                Text("Optional Health Details")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.white)

                Text("These are optional for account creation. Some trainers may request them later.")
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            VStack(spacing: 14) {
                SignUpTextField(placeholder: "Age (optional)", text: $form.age, keyboardType: .numberPad, textInputAutocapitalization: .never)
                SignUpTextField(placeholder: "Sex (optional)", text: $form.sex, textInputAutocapitalization: .words)
                SignUpTextField(placeholder: "Height (optional)", text: $form.height, textInputAutocapitalization: .never)
                SignUpTextField(placeholder: "Weight (optional)", text: $form.weight, textInputAutocapitalization: .never)

                VStack(alignment: .leading, spacing: 6) {
                    Text("Goals / Notes (optional)")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.8))

                    TextEditor(text: $form.goal)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 110)
                        .padding(10)
                        .background(Color.white.opacity(0.08))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.white.opacity(0.18), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(.white)
                }
            }

            HStack(spacing: 12) {
                SignUpSecondaryButton(title: "Back", systemImage: "chevron.left") {
                    onBack()
                }

                SignUpContinueButton(
                    title: isSubmitting ? "Finishing..." : "Finish",
                    isLoading: isSubmitting,
                    isDisabled: isSubmitting
                ) {
                    onFinish()
                }
            }
        }
    }
}
