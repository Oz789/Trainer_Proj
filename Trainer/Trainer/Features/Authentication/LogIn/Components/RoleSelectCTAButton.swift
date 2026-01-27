//
//  RoleCTAButton.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 1/27/26.
//


import SwiftUI

struct RoleSelectCTAButton: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var theme: AppTheme { themeManager.theme }

    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: 320)
                .frame(height: 54)
                .background(
                    LinearGradient(colors: theme.ctaGradient, startPoint: .leading, endPoint: .trailing)
                )
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .shadow(color: .black.opacity(0.35), radius: 14, x: 0, y: 10)
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        RoleSelectCTAButton(title: "Trainer") {}
        RoleSelectCTAButton(title: "User") {}
    }
    .padding()
    .background(Color.black)
    .environmentObject(ThemeManager())
    .preferredColorScheme(.dark)
}
