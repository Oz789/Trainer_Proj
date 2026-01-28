//
//  TSUPrimaryButton.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 1/27/26.
//


import SwiftUI

struct SignUpContinueButton: View {
    let title: String
    var isLoading: Bool = false
    var isDisabled: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if isLoading { ProgressView() }
                Text(title).fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
        }
        .disabled(isDisabled || isLoading)
        .background(
            LinearGradient(colors: [.green, .mint], startPoint: .leading, endPoint: .trailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .foregroundStyle(.white)
        .shadow(color: .black.opacity(0.35), radius: 10, y: 8)
        .opacity((isDisabled || isLoading) ? 0.7 : 1.0)
    }
}
