import SwiftUI

struct TrainerSignUpMainView: View {
    var onSignedUp: (() -> Void)? = nil

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = TrainerSignUpViewModel()

    @State private var showCancelConfirm = false

    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ZStack {
                SignUpBackground()

                ScrollView {
                    VStack(spacing: 18) {
                        Spacer().frame(height: 40)

                        TrainerSignUpHeader()

                        TrainerSignUpFormView(
                            form: $viewModel.form,
                            errors: viewModel.fieldErrors
                        )

                        Text("* Indicates a required field")
                            .font(.caption2)
                            .foregroundStyle(.white.opacity(0.55))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        SignUpSecondaryButton(
                            title: "Choose a Profile Picture",
                            systemImage: "person.crop.circle.badge.plus"
                        ) {
                            // TODO: image picker later
                        }

                        SignUpContinueButton(
                            title: viewModel.isSubmitting ? "Creating Account..." : "Continue",
                            isLoading: viewModel.isSubmitting,
                            isDisabled: !viewModel.canContinue
                        ) {
                            viewModel.validateAndContinue()
                        }

                        Spacer(minLength: 20)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
            .ignoresSafeArea()
            .hideKeyboardOnTap()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { showCancelConfirm = true }
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
            .navigationDestination(for: TrainerSignUpViewModel.Route.self) { route in
                switch route {
                case .profile:
                    TrainerProfileMainView()
                }
            }
        }
    }
}

#Preview("Trainer Sign Up") {
    let tm = ThemeManager()
    tm.apply("theme.green")

    return TrainerSignUpMainView()
        .environmentObject(tm)
}
