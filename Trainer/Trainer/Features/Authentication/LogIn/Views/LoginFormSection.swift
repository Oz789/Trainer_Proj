import SwiftUI

struct LoginFormSection: View {
    @Binding var email: String
    @Binding var password: String

    var body: some View {
        VStack(spacing: 14) {
            GlassField(placeholder: "Email", text: $email, isSecure: false)
            GlassField(placeholder: "Password", text: $password, isSecure: true)

            LogInCTAButton(title: "Log In") {
                // no wiring yet
            }
            .padding(.top, 10)
        }
    }
}

#Preview {
    LoginFormSection(email: .constant(""), password: .constant(""))
        .padding()
        .background(Color.black)
        .environmentObject(ThemeManager())
        .preferredColorScheme(.dark)
}
