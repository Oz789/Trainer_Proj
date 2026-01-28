//
//  TrainerSignUpBackground.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 1/27/26.
//


import SwiftUI

struct SignUpBackground: View {
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        // Until we map exact theme tokens, we keep this consistent and minimal.
        LinearGradient(
            colors: [Color.black, Color(white: 0.14)],
            startPoint: .top,
            endPoint: .bottom
        )
        .overlay(
            LinearGradient(
                colors: [Color.white.opacity(0.06), .clear, .black.opacity(0.25)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}
