import SwiftUI

struct SignUpRoleSection: View {
    let onTrainer: () -> Void
    let onUser: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            RoleSelectCTAButton(title: "Trainer", action: onTrainer)
            RoleSelectCTAButton(title: "User", action: onUser)
        }
    }
}

#Preview {
    SignUpRoleSection(onTrainer: {}, onUser: {})
        .padding()
        .background(Color.black)
        .environmentObject(ThemeManager())
        .preferredColorScheme(.dark)
}
