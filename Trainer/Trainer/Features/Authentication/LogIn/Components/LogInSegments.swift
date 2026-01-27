//
//  AuthSegmentedControl.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 1/27/26.
//


import SwiftUI

struct LogInSegments: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var theme: AppTheme { themeManager.theme }

    @Binding var isLoginMode: Bool

    var body: some View {
        Picker("", selection: $isLoginMode) {
            Text("Log In").tag(true)
            Text("Sign Up").tag(false)
        }
        .pickerStyle(.segmented)
        .frame(maxWidth: 320)
        .tint(theme.segmentedTint)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(theme.segmentedBackground)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    LogInSegments(isLoginMode: .constant(true))
        .padding()
        .background(Color.black)
        .environmentObject(ThemeManager())
        .preferredColorScheme(.dark)
}
