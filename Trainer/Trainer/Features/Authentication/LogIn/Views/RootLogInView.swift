import SwiftUI

struct RootLogInView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme

    private var themeToken: ThemeTokens {
        themeManager.tokens(for: scheme)
    }


    @State private var isLoginMode: Bool = true
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showTrainerSignUp = false
    @State private var showUserSignUp = false

    // dev theme cycling
    @State private var themeIndex: Int = 0

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: themeToken.backgroundGradient,
                    startPoint: UnitPoint(x: 0.5, y: 0.10),
                    endPoint: UnitPoint(x: 0.5, y: 0.95)
                )
                .ignoresSafeArea()

                VStack {
                    Spacer()

                    VStack(spacing: 18) {
                        
                        Text("TRAINER")
                            .font(.system(size: 38, weight: .bold))
                            .foregroundColor(themeToken.titleColor)

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

                // dev button — delete later
                VStack {
                    HStack {
                        Button("NEXT THEME") {
                            let themes = themeManager.allThemes
                            guard !themes.isEmpty else { return }

                            themeIndex = (themeIndex + 1) % themes.count
                            themeManager.apply(themes[themeIndex].id)
                        }
                        .padding(10)
                        .background(Color.black.opacity(0.6))
                        .foregroundColor(.white)

                        Spacer()
                    }
                    .padding(.top, 12)
                    .padding(.leading, 12)

                    Spacer()
                }
            }
        }
        .fullScreenCover(isPresented: $showTrainerSignUp) {
            TrainerSignUpMainView()
                .environmentObject(themeManager)
        }
        .fullScreenCover(isPresented: $showUserSignUp) {
            UserSignUpMainView()
                .environmentObject(themeManager)
        }
    }
}

#Preview {
    RootLogInView()
        .environmentObject(ThemeManager())
        .preferredColorScheme(.light)
}
