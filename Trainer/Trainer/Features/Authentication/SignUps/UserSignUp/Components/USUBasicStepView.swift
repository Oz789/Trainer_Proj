import SwiftUI

struct UserSignUpBasicStepView: View {
    @Binding var form: UserSignUpFormModel
    let errors: [UserSignUpViewModel.Field: String]
    let isSubmitting: Bool
    let canContinue: Bool
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: 18) {
            UserSignUpHeader()

            VStack(spacing: 14) {
                HStack(spacing: 12) {
                    SignUpTextField(
                        placeholder: "First Name*",
                        text: $form.firstName,
                        textInputAutocapitalization: .words,
                        error: errors[.firstName]
                    )

                    SignUpTextField(
                        placeholder: "Last Name*",
                        text: $form.lastName,
                        textInputAutocapitalization: .words,
                        error: errors[.lastName]
                    )
                }

                SignUpTextField(
                    placeholder: "Email Address*",
                    text: $form.email,
                    keyboardType: .emailAddress,
                    textInputAutocapitalization: .never,
                    error: errors[.email],
                    footnote: "Use a valid email like name@example.com"
                )

                SignUpPasswordField(
                    placeholder: "Password*",
                    text: $form.password,
                    error: errors[.password],
                    footnote: "Password must be at least 6 characters."
                )
            }

            Text("* Indicates a required field")
                .font(.caption2)
                .foregroundStyle(.white.opacity(0.55))
                .frame(maxWidth: .infinity, alignment: .leading)

            SignUpContinueButton(
                title: isSubmitting ? "Continuing..." : "Continue",
                isLoading: isSubmitting,
                isDisabled: !canContinue,
                action: onContinue
            )
        }
    }
}
