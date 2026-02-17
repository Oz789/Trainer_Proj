import SwiftUI

struct UserSignUpMainView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var session: SessionManager

    @StateObject private var viewModel = UserSignUpViewModel()
    @State private var showCancelConfirm = false

    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ZStack {
                SignUpBackground()

                ScrollView {
                    VStack(spacing: 18) {
                        Spacer().frame(height: 40)

                        UserSignUpBasicStepView(
                            form: $viewModel.form,
                            errors: viewModel.fieldErrors,
                            isSubmitting: viewModel.isSubmitting,
                            canContinue: viewModel.canContinue
                        ) {
                            viewModel.goToDetails()
                        }

                        Spacer(minLength: 20)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
            .ignoresSafeArea()
            .hideKeyboardOnTap()
            .navigationDestination(for: UserSignUpViewModel.Route.self) { route in
                switch route {
                case .details:
                    ZStack {
                        SignUpBackground()

                        ScrollView {
                            VStack(spacing: 18) {
                                Spacer().frame(height: 40)

                                UserSignUpDetailsStepView(
                                    form: $viewModel.form,
                                    isSubmitting: viewModel.isSubmitting,
                                    onBack: { viewModel.backFromDetails() },
                                    onFinish: {
                                        Task { await viewModel.finish(session: session) }
                                    }
                                )

                                Spacer(minLength: 20)
                            }
                            .padding(.horizontal, 24)
                            .padding(.bottom, 40)
                        }
                    }
                    .ignoresSafeArea()
                    .hideKeyboardOnTap()
                    .navigationBarBackButtonHidden(true)

                case .profile:
                    UserProfileMainView()
                        .environmentObject(session)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { showCancelConfirm = true }
                }
            }
        }
        .alert("Cancel sign up?", isPresented: $showCancelConfirm) {
            Button("Continue", role: .cancel) {}
            Button("Cancel", role: .destructive) { dismiss() }
        }
        .alert("Sign Up Failed", isPresented: $viewModel.showErrorAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

#Preview {
    let tm = ThemeManager()
    tm.apply("theme.horizon")

    let session = SessionManager()

    return UserSignUpMainView()
        .environmentObject(tm)
        .environmentObject(session)
        .preferredColorScheme(.dark)
}
