import SwiftUI

struct TrainerSignUpHeader: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Create Your\nTrainer Profile")
                .font(.system(size: 26, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
        }
        .padding(.bottom, 6)
    }
}
