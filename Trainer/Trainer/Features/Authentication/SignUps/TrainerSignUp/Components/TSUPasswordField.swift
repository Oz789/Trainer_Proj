//
//  TSUSecureField.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 1/27/26.
//


import SwiftUI

struct TSUPasswordField: View {
    let placeholder: String
    @Binding var text: String

    var error: String? = nil
    var footnote: String? = nil

    var body: some View {
        VStack(spacing: 6) {
            SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.7)))
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(error == nil ? Color.white.opacity(0.18) : Color.red.opacity(0.9), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(.white)

            if let error {
                Text(error)
                    .font(.caption2)
                    .foregroundStyle(Color.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else if let footnote {
                Text(footnote)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
