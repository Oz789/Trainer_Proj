import SwiftUI
import FirebaseAuth

struct RootLogInView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var session: SessionManager
    @Environment(\.colorScheme) private var scheme

    private var themeToken: ThemeTokens { themeManager.tokens(for: scheme) }

    @State private var isLoginMode: Bool = true
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showTrainerSignUp = false
    @State private var showUserSignUp = false
    @State private var isSubmitting: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""

// dev theme button to delete later
    @State private var themeIndex: Int = 0

    private var trimmedEmail: String {
        email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AuthBackgroundView(themeToken: themeToken)

                VStack {
                    Spacer()

                    VStack(spacing: 18) {
                        AuthHeaderView(titleColor: themeToken.titleColor)

                        LogInSegments(isLoginMode: $isLoginMode)
                            .disabled(isSubmitting)

                        AuthCardContent(
                            isLoginMode: isLoginMode,
                            email: $email,
                            password: $password,
                            isSubmitting: isSubmitting,
                            onLogin: { Task { await handleSignIn() } },
                            onForgotPassword: { Task { await handlePasswordReset() } },
                            onTrainerSignUp: { showTrainerSignUp = true },
                            onUserSignUp: { showUserSignUp = true }
                        )
                    }

                    Spacer()
                }
                .padding(.horizontal, 22)

                DevThemeCycleButton(
                    isSubmitting: isSubmitting,
                    themeManager: themeManager,
                    themeIndex: $themeIndex
                )
            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            .navigationDestination(isPresented: $showTrainerSignUp) {
                TrainerSignUpMainView(onSignedUp: { showTrainerSignUp = false })
                    .environmentObject(themeManager)
            }
            .navigationDestination(isPresented: $showUserSignUp) {
                UserSignUpMainView()
                    .environmentObject(themeManager)
            }
        }
    }

    // MARK: - Actions

    @MainActor
    private func handleSignIn() async {
        guard !isSubmitting else { return }

        // Lightweight UX validation
        guard trimmedEmail.contains("@"), password.count >= 6 else {
            presentAlert(
                title: "Check your info",
                message: "Enter a valid email and a password that’s at least 6 characters."
            )
            return
        }

        isSubmitting = true
        defer { isSubmitting = false }

        do {
            try await AuthService.shared.signIn(email: trimmedEmail, password: password)
            // SessionManager handles routing via auth listener.
        } catch {
            let mapped = AuthErrorMapper.displayInfo(for: error)
            presentAlert(title: mapped.title, message: mapped.message)
        }
    }

    @MainActor
    private func handlePasswordReset() async {
        guard !isSubmitting else { return }

        guard !trimmedEmail.isEmpty else {
            presentAlert(title: "Enter your email", message: "Type your email above, then tap “Forgot password?”.")
            return
        }

        isSubmitting = true
        defer { isSubmitting = false }

        do {
            try await AuthService.shared.sendPasswordReset(to: trimmedEmail)
            presentAlert(
                title: "Email sent",
                message: "If an account exists for \(trimmedEmail), you’ll receive a reset email shortly."
            )
        } catch {
            let mapped = AuthErrorMapper.displayInfo(for: error)
            presentAlert(title: mapped.title, message: mapped.message)
        }
    }

    @MainActor
    private func presentAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

#Preview {
    let tm = ThemeManager()
    tm.apply("theme.Cinder")

    let session = SessionManager()
    return RootLogInView()
        .environmentObject(tm)
        .environmentObject(session)
        .preferredColorScheme(.dark)
}
