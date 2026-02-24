//
//  TRInputField.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 2/23/26.
//


import SwiftUI

// MARK: - Shared UI Components

struct TRInputField: View {
    let placeholder: String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default

    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboard)
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .foregroundStyle(.white)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.20), lineWidth: 1)
            )
    }
}

struct TRTextArea: View {
    let placeholder: String
    @Binding var text: String
    var minLines: Int = 4
    var maxLines: Int = 8

    var body: some View {
        TextField(placeholder, text: $text, axis: .vertical)
            .lineLimit(minLines...maxLines)
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .foregroundStyle(.white)
            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.20), lineWidth: 1)
            )
    }
}

struct TRMenuPill<Content: View>: View {
    let title: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        Menu {
            content()
        } label: {
            HStack(spacing: 8) {
                Text(title)
                    .foregroundStyle(.white.opacity(0.95))
                Image(systemName: "chevron.up.chevron.down")
                    .font(.footnote.weight(.bold))
                    .foregroundStyle(.white.opacity(0.7))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.20), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

extension View {
    func trCardStyle() -> some View {
        self
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.20), lineWidth: 1)
            )
    }
}
