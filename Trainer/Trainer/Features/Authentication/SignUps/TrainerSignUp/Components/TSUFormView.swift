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
                TSUTextField(
                    placeholder: "First Name*",
                    text: $form.firstName,
                    textInputAutocapitalization: .words,
                    error: errors[.firstName]
                )

                TSUTextField(
                    placeholder: "Last Name*",
                    text: $form.lastName,
                    textInputAutocapitalization: .words,
                    error: errors[.lastName]
                )
            }

            TSUTextField(
                placeholder: "Email Address*",
                text: $form.email,
                keyboardType: .emailAddress,
                textInputAutocapitalization: .never,
                error: errors[.email],
                footnote: "Use a valid email like name@example.com"
            )

            TSUPasswordField(
                placeholder: "Password*",
                text: $form.password,
                error: errors[.password],
                footnote: "Password must be at least 6 characters."
            )

            TSUTextField(
                placeholder: "User Display Name (optional)",
                text: $form.displayName,
                textInputAutocapitalization: .words
            )

            TSUTextField(placeholder: "Age (optional)", text: $form.age, keyboardType: .numberPad, textInputAutocapitalization: .never)
            TSUTextField(placeholder: "Gender (optional)", text: $form.gender, textInputAutocapitalization: .words)
            TSUTextField(placeholder: "Height (optional)", text: $form.height, textInputAutocapitalization: .never)
            TSUTextField(placeholder: "Weight (optional)", text: $form.weight, textInputAutocapitalization: .never)
        }
    }
}
