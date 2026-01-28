//
//  TrainerSignUpFormView.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 1/27/26.
//


import SwiftUI

struct TrainerSignUpFormView: View {
    @Binding var form: TrainerSignUpFormModel
    let errors: [TrainerSignUpViewModel.Field: String]

    var body: some View {
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

            SignUpTextField(
                placeholder: "User Display Name (optional)",
                text: $form.displayName,
                textInputAutocapitalization: .words
            )

            SignUpTextField(placeholder: "Age (optional)", text: $form.age, keyboardType: .numberPad, textInputAutocapitalization: .never)
            SignUpTextField(placeholder: "Gender (optional)", text: $form.gender, textInputAutocapitalization: .words)
            SignUpTextField(placeholder: "Height (optional)", text: $form.height, textInputAutocapitalization: .never)
            SignUpTextField(placeholder: "Weight (optional)", text: $form.weight, textInputAutocapitalization: .never)
        }
    }
}
