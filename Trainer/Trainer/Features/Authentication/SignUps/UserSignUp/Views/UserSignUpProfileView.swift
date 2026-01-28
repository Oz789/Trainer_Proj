//
//  UserSignUpProfileView.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 1/27/26.
//


import SwiftUI

struct UserSignUpProfileView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Profile")
                .font(.title2.weight(.semibold))
            Text("No Firebase yet — this is just a placeholder screen.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .foregroundStyle(.white)
    }
}

#Preview {
    UserSignUpProfileView()
}
