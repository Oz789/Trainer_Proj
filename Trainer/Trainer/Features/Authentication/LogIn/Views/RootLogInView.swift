import SwiftUI

struct RootLogInView: View {

    @State private var isLoginMode: Bool = true
    @State private var email: String = ""
    @State private var password: String = ""

    // Temporary tokens - replace with ThemeManager
    private let bgGradient: [Color] = [
        .black,
        Color(red: 0.13, green: 0.13, blue: 0.13)
    ]

    private let ctaGradient: [Color] = [
        Color(red: 0.68, green: 0.32, blue: 0.98),
        Color(red: 1.00, green: 0.27, blue: 0.45)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: bgGradient,
                    startPoint: UnitPoint(x: 0.5, y: 0.10),
                    endPoint: UnitPoint(x: 0.5, y: 0.95)
                )
                .ignoresSafeArea()

                VStack {
                    Spacer()

                    VStack(spacing: 18) {
                        Text("TRAINER")
                            .font(.system(size: 38, weight: .bold))
                            .foregroundColor(.white)

                        Picker("", selection: $isLoginMode) {
                            Text("Log In").tag(true)
                            Text("Sign Up").tag(false)
                        }
                        .pickerStyle(.segmented)
                        .frame(maxWidth: 320)
                        .tint(Color.white.opacity(0.22))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.10))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                        VStack(spacing: 14) {
                            GlassField(placeholder: "Email", text: $email, isSecure: false)
                            GlassField(placeholder: "Password", text: $password, isSecure: true)
                        }

                        PrimaryCTAButton(title: "Log In", gradient: ctaGradient) {
                            // mock action for now
                        }
                        .padding(.top, 10)
                    }

                    Spacer()
                }
                .padding(.horizontal, 22)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RootLogInView()
}
