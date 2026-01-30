//
//  ProfileSettingsButton.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 1/29/26.
//


import SwiftUI

struct ProfileSettingsButton: View {
    var body: some View {
        NavigationLink {
            SettingsMainView()
        } label: {
            Image(systemName: "gearshape")
                .foregroundStyle(.white)
        }
        .accessibilityLabel("Settings")
    }
}

#Preview {
    let tm = ThemeManager()
    tm.apply("theme.green")
    return NavigationStack {
        ZStack {
            Color.black.ignoresSafeArea()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ProfileSettingsButton()
            }
        }
    }
    .environmentObject(tm)
}
