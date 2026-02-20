import SwiftUI

struct RootLogInView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var session: SessionManager
    @Environment(\.colorScheme) private var scheme
    @StateObject private var vm = RootLogInViewModel()

    #if DEBUG
    @State private var devThemeIndex: Int = 0
    #endif

    private var themeToken: ThemeTokens { themeManager.tokens(for: scheme) }

    private var canSubmitLogin: Bool {
        vm.trimmedEmail.contains("@") && vm.password.count >= 6 && !vm.isSubmitting
    }

    var body: some View {
        NavigationStack {
            ZStack {
                //Bacckground
                LinearGradient(
                    colors: themeToken.backgroundGradient,
                    startPoint: UnitPoint(x: 0.5, y: 0.10),
                    endPoint: UnitPoint(x: 0.5, y: 0.95)
                )
                .ignoresSafeArea()

                VStack {
                    Spacer()
                    //Header
                    VStack(spacing: 18) {
                        Text("TRAINER")
                            .font(.system(size: 38, weight: .bold))
                            .foregroundColor(themeToken.titleColor)
                        //Pill Switcher
                        LogInSignUpPills(isLoginMode: $vm.isLoginMode)
                            .disabled(vm.isSubmitting)
                        
                        //Log in Section
                        if vm.isLoginMode {
                            VStack(spacing: 12) {
                                LoginFormSection(
                                    email: $vm.email,
                                    password: $vm.password,
                                    isSubmitting: vm.isSubmitting,
                                    canSubmit: canSubmitLogin,
                                    onLogin: { Task { await vm.signIn(session: session) } }
                                )
                                .disabled(vm.isSubmitting)

                                Button {
                                    Task { await vm.sendPasswordReset(session: session) }
                                } label: {
                                    Text("Forgot password?")
                                        .font(.footnote.weight(.semibold))
                                        .foregroundStyle(.white.opacity(0.75))
                                }
                                .disabled(vm.isSubmitting || vm.trimmedEmail.isEmpty)
                            }
                        } else {
                            //Sign up Section
                            SignUpRoleButtons(
                                onTrainer: { vm.showTrainerSignUp = true },
                                onUser: { vm.showUserSignUp = true }
                            )
                            .disabled(vm.isSubmitting)
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 22)

                #if DEBUG
                DevThemeOverlay(
                    isDisabled: vm.isSubmitting,
                    themeManager: themeManager,
                    themeIndex: $devThemeIndex
                )
                #endif
            }
            .alert(vm.alertTitle, isPresented: $vm.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(vm.alertMessage)
            }
            .navigationDestination(isPresented: $vm.showTrainerSignUp) {
                TrainerSignUpMainView(onSignedUp: { vm.showTrainerSignUp = false })
                    .environmentObject(themeManager)
            }
            .navigationDestination(isPresented: $vm.showUserSignUp) {
                UserSignUpMainView()
                    .environmentObject(themeManager)
            }
        }
    }
}
