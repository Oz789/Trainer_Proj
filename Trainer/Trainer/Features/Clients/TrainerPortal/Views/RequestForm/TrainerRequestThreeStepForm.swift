import SwiftUI

struct TrainerRequestThreeStepFormView: View {
    enum Step: Int { case basics = 1, details = 2, review = 3 }
    @State private var step: Step = .basics
    @State private var form = TrainerRequestPayload()
    @State private var ageText: String = ""
    @State private var feetText: String = ""
    @State private var inchesText: String = ""
    @FocusState private var focused: Field?

    var onSubmit: ((TrainerRequestPayload) -> Void)? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        header
                        stepIndicator

                        switch step {
                        case .basics:
                            TrainerRequestStepBasicsView(
                                form: $form,
                                ageText: $ageText,
                                feetText: $feetText,
                                inchesText: $inchesText,
                                focused: $focused
                            )
                            .transition(.opacity.combined(with: .move(edge: .trailing)))

                        case .details:
                            TrainerRequestStepDetailsView(
                                form: $form,
                                focused: $focused
                            )
                            .transition(.opacity.combined(with: .move(edge: .leading)))

                        case .review:
                            TrainerRequestStepReviewView(form: form)
                                .transition(.opacity)
                        }

                        footerButtons
                        Spacer(minLength: 18)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 18)
                    .padding(.bottom, 24)
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") { focused = nil }
                }
            }
            .simultaneousGesture(TapGesture().onEnded { focused = nil })
            .navigationTitle("Client Form")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.dark)
        // Keep payload ints synced with text fields
        .onChange(of: ageText) { _, newValue in form.age = Int(newValue) }
        .onChange(of: feetText) { _, newValue in form.heightFeet = Int(newValue) }
        .onChange(of: inchesText) { _, newValue in form.heightInches = Int(newValue) }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Client Form")
                .font(.system(size: 26, weight: .bold))
                .foregroundStyle(.white)

            Text(subtitleForStep)
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.70))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var subtitleForStep: String {
        switch step {
        case .basics: return "Step 1 of 3 — Basics"
        case .details: return "Step 2 of 3 — Details"
        case .review: return "Step 3 of 3 — Review"
        }
    }

    private var stepIndicator: some View {
        HStack(spacing: 10) {
            stepPill("1", isActive: step == .basics)
            Rectangle().fill(Color.white.opacity(0.12)).frame(height: 1)
            stepPill("2", isActive: step == .details)
            Rectangle().fill(Color.white.opacity(0.12)).frame(height: 1)
            stepPill("3", isActive: step == .review)
        }
        .padding(.vertical, 2)
    }

    private func stepPill(_ text: String, isActive: Bool) -> some View {
        Text(text)
            .font(.footnote.weight(.bold))
            .foregroundStyle(isActive ? .black : .white.opacity(0.85))
            .frame(width: 28, height: 28)
            .background(isActive ? Color.white : Color.white.opacity(0.10), in: Circle())
            .overlay(Circle().stroke(Color.white.opacity(0.18), lineWidth: 1))
    }

    private var footerButtons: some View {
        HStack(spacing: 12) {
            if step != .basics {
                Button {
                    focused = nil
                    withAnimation(.easeInOut(duration: 0.18)) {
                        step = previousStep(step)
                    }
                } label: {
                    Text("Back")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(Color.white.opacity(0.20), lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
            }

            Button {
                focused = nil

                if step == .basics {
                    withAnimation(.easeInOut(duration: 0.18)) { step = .details }
                } else if step == .details {
                    withAnimation(.easeInOut(duration: 0.18)) { step = .review }
                } else {
                    // Review -> Submit
                    onSubmit?(form)
                }
            } label: {
                Text(primaryButtonTitle)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        LinearGradient(colors: [.purple, .pink],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing),
                        in: RoundedRectangle(cornerRadius: 14, style: .continuous)
                    )
            }
            .buttonStyle(.plain)
            .disabled(isPrimaryDisabled)
            .opacity(isPrimaryDisabled ? 0.55 : 1.0)
        }
        .padding(.top, 6)
    }

    private var primaryButtonTitle: String {
        switch step {
        case .basics: return "Next"
        case .details: return "Review"
        case .review: return "Submit"
        }
    }

    private var isPrimaryDisabled: Bool {
        if step == .basics { return !form.canAdvanceFromBasics }
        return false
    }

    private func previousStep(_ current: Step) -> Step {
        switch current {
        case .basics: return .basics
        case .details: return .basics
        case .review: return .details
        }
    }


    enum Field {
        case age, feet, inches, goalCustom, timeframe, injuries, conditions, notes
    }
}

#Preview {
    TrainerRequestThreeStepFormView { payload in
        print(payload)
    }
}
