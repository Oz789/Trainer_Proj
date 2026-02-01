import SwiftUI

struct TrainerSignUpMainView: View {
    var onSignedUp: (() -> Void)? = nil

    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var scheme
    
    @StateObject private var viewModel = TrainerSignUpViewModel()
    
    @State private var showCancelConfirm = false

    var body: some View {
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
                    ) { }

                    SignUpContinueButton(
                        title: viewModel.isSubmitting ? "Creating Account..." : "Continue",
                        isLoading: viewModel.isSubmitting,
                        isDisabled: !viewModel.canContinue
                    ) {
                        viewModel.validateAndContinue {
                            onSignedUp?()
                        }
                    }

                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .ignoresSafeArea()
        .hideKeyboardOnTap()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                }
            }

        }
        .tint(scheme == .dark ? .white : .black)

    }
}


#Preview("Trainer Sign Up") {
    let tm = ThemeManager()
    tm.apply("theme.green")

    return TrainerSignUpMainView()
        .environmentObject(tm)
}
