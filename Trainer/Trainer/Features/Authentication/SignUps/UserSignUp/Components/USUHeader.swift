import SwiftUI

struct UserSignUpHeader: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Create Your\nProfile")
                .font(.system(size: 26, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)

            Text("Start with the basics, then add optional health details.")
                .font(.system(size: 14, weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.75))
        }
        .padding(.bottom, 6)
    }
}

