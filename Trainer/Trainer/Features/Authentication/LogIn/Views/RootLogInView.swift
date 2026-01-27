import SwiftUI

struct RootLogInView: View {

    @EnvironmentObject private var themeManager: ThemeManager
    private var theme: AppTheme { themeManager.theme }
    @State private var isLoginMode: Bool = true
    @State private var email: String = ""
    @State private var password: String = ""
    // for starting the flow (we’ll wire these later)
    @State private var showTrainerSignUp = false
    @State private var showUserSignUp = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: theme.backgroundGradient,
                    startPoint: UnitPoint(x: 0.5, y: 0.10),
                    endPoint: UnitPoint(x: 0.5, y: 0.95)
                )
                .ignoresSafeArea()

                VStack {
                    Spacer()

                    VStack(spacing: 18) {
                        Text("TRAINER")
                            .font(.system(size: 38, weight: .bold))
                            .foregroundColor(theme.titleColor)

                       LogInSegments(isLoginMode: $isLoginMode)

                        Group {
                            if isLoginMode {
                                LoginFormSection(email: $email, password: $password)
                            } else {
                                SignUpRoleSection(
                                    onTrainer: { showTrainerSignUp = true },
                                    onUser: { showUserSignUp = true }
                                )
                            }
                        }
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.25), value: isLoginMode)
                    }

                    Spacer()
                }
                .padding(.horizontal, 22)
            }
        }
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $showTrainerSignUp) {
            // placeholder for now:
            Text("Trainer Sign Up")
                .foregroundColor(.white)
                .background(Color.black.ignoresSafeArea())
        }
        .fullScreenCover(isPresented: $showUserSignUp) {
            // placeholder for now:
            Text("User Sign Up")
                .foregroundColor(.white)
                .background(Color.black.ignoresSafeArea())
        }
    }
}

#Preview {
    RootLogInView()
        .environmentObject(ThemeManager())
        .preferredColorScheme(.dark)
}
