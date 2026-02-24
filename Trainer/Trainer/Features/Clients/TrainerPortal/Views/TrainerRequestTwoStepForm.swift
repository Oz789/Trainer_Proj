import SwiftUI

struct TrainerRequestTwoStepForm: View {
    // MARK: - Step Control
    enum Step: Int { case basics = 1, details = 2 }
    @State private var step: Step = .basics

    // MARK: - Fields
    @State private var age: String = ""
    @State private var sex: Sex = .unspecified

    @State private var heightFeet: String = ""
    @State private var heightInches: String = ""

    @State private var experience: Experience = .beginner

    // Hybrid goal: preset + optional custom
    @State private var goalPreset: GoalPreset = .hypertrophy
    @State private var goalCustom: String = ""

    @State private var timeframe: String = ""

    @State private var injuries: String = ""
    @State private var conditions: String = ""

    @State private var availabilityDaysPerWeek: Int = 3
    @State private var equipment: Equipment = .gym

    @State private var notes: String = ""

    // MARK: - Focus
    @FocusState private var focused: Field?

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        header

                        stepIndicator

                        if step == .basics {
                            basicsStep
                                .transition(.opacity.combined(with: .move(edge: .trailing)))
                        } else {
                            detailsStep
                                .transition(.opacity.combined(with: .move(edge: .leading)))
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
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Client Form")
                .font(.system(size: 26, weight: .bold))
                .foregroundStyle(.white)

            Text(step == .basics ? "Step 1 of 2 — Basics" : "Step 2 of 2 — Details")
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.70))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var stepIndicator: some View {
        HStack(spacing: 10) {
            stepPill("1", isActive: step == .basics)
            Rectangle()
                .fill(Color.white.opacity(0.12))
                .frame(height: 1)
            stepPill("2", isActive: step == .details)
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

    // MARK: - Step 1 (Basics)

    private var basicsStep: some View {
        VStack(spacing: 14) {
            HStack(spacing: 12) {
                inputField("Age", text: $age)
                    .keyboardType(.numberPad)
                    .focused($focused, equals: .age)

                menuPill(title: sex.display) {
                    Picker("", selection: $sex) {
                        Text("Prefer not to say").tag(Sex.unspecified)
                        Text("Male").tag(Sex.male)
                        Text("Female").tag(Sex.female)
                    }
                }
            }

            HStack(spacing: 12) {
                inputField("Height (ft)", text: $heightFeet)
                    .keyboardType(.numberPad)
                    .focused($focused, equals: .feet)

                inputField("in", text: $heightInches)
                    .keyboardType(.numberPad)
                    .focused($focused, equals: .inches)
                    .frame(width: 110)
            }

            menuPill(title: experience.label) {
                Picker("", selection: $experience) {
                    ForEach(Experience.allCases, id: \.self) { exp in
                        Text(exp.label).tag(exp)
                    }
                }
            }

            menuPill(title: goalPreset.displayName) {
                Picker("", selection: $goalPreset) {
                    ForEach(GoalPreset.allCases, id: \.self) { g in
                        Text(g.displayName).tag(g)
                    }
                }
            }

            if goalPreset == .custom {
                inputField("Custom goal (optional)", text: $goalCustom)
                    .focused($focused, equals: .goalCustom)
            }

            inputField("Timeframe (e.g., 8 weeks)", text: $timeframe)
                .focused($focused, equals: .timeframe)
        }
        .animation(.easeInOut(duration: 0.18), value: goalPreset)
    }

    // MARK: - Step 2 (Details)

    private var detailsStep: some View {
        VStack(spacing: 14) {
            inputField("Any injuries (e.g., none)", text: $injuries)
                .focused($focused, equals: .injuries)

            inputField("Any conditions (e.g., none)", text: $conditions)
                .focused($focused, equals: .conditions)

            VStack(alignment: .leading, spacing: 10) {
                Text("Availability")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)

                Stepper(value: $availabilityDaysPerWeek, in: 1...7) {
                    Text("\(availabilityDaysPerWeek) days / week")
                        .foregroundStyle(.white.opacity(0.85))
                }
                .tint(.white)
            }
            .cardStyle()

            menuPill(title: "Equipment: \(equipment.displayName)") {
                Picker("", selection: $equipment) {
                    ForEach(Equipment.allCases, id: \.self) { eq in
                        Text(eq.displayName).tag(eq)
                    }
                }
            }

            textArea("Extra notes for your trainer (optional)", text: $notes)
                .focused($focused, equals: .notes)
        }
    }

    // MARK: - Footer Buttons

    private var footerButtons: some View {
        HStack(spacing: 12) {
            if step == .details {
                Button {
                    focused = nil
                    withAnimation(.easeInOut(duration: 0.18)) { step = .basics }
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
                } else {
                    submit()
                }
            } label: {
                Text(step == .basics ? "Next" : "Submit")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        LinearGradient(
                            colors: [.purple, .pink],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        in: RoundedRectangle(cornerRadius: 14, style: .continuous)
                    )
            }
            .buttonStyle(.plain)
            .disabled(step == .basics && !canAdvanceFromBasics)
            .opacity(step == .basics && !canAdvanceFromBasics ? 0.55 : 1.0)
        }
        .padding(.top, 6)
    }

    private var canAdvanceFromBasics: Bool {
        // Keep minimal requirements so it doesn't feel strict:
        // Age optional, but goal/timeframe should be present.
        let tf = timeframe.trimmingCharacters(in: .whitespacesAndNewlines)
        return !tf.isEmpty
    }

    // MARK: - Submit

    private func submit() {
        // Placeholder: later we pass this payload to a ViewModel/service to insert in Supabase.
        print("SUBMIT:")
        print("age:", age)
        print("sex:", sex.display)
        print("height:", heightFeet, "ft", heightInches, "in")
        print("experience:", experience.label)
        print("goal:", goalPreset == .custom ? goalCustom : goalPreset.displayName)
        print("timeframe:", timeframe)
        print("injuries:", injuries)
        print("conditions:", conditions)
        print("availability:", availabilityDaysPerWeek)
        print("equipment:", equipment.displayName)
        print("notes:", notes)
    }

    // MARK: - UI Helpers

    private func inputField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .foregroundStyle(.white)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.20), lineWidth: 1)
            )
    }

    private func textArea(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text, axis: .vertical)
            .lineLimit(4...8)
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .foregroundStyle(.white)
            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.20), lineWidth: 1)
            )
    }

    private func menuPill<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        Menu {
            content()
        } label: {
            HStack(spacing: 8) {
                Text(title)
                    .foregroundStyle(.white.opacity(0.95))
                Image(systemName: "chevron.up.chevron.down")
                    .font(.footnote.weight(.bold))
                    .foregroundStyle(.white.opacity(0.7))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.20), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }

    private enum Field {
        case age, feet, inches, goalCustom, timeframe, injuries, conditions, notes
    }
}

// MARK: - Card helper

private extension View {
    func cardStyle() -> some View {
        self
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.20), lineWidth: 1)
            )
    }
}

// MARK: - Enums

enum Sex: Hashable {
    case male, female, unspecified
    var display: String {
        switch self {
        case .male: return "Male"
        case .female: return "Female"
        case .unspecified: return "Prefer not to say"
        }
    }
}

enum Experience: String, CaseIterable, Hashable {
    case beginner, intermediate, advanced, new

    var label: String {
        switch self {
        case .new: return "New"
        case .beginner: return "Beginner 0–1 Years"
        case .intermediate: return "Intermediate 2–5 Years"
        case .advanced: return "Advanced 5+ Years"
        }
    }
}

enum GoalPreset: String, CaseIterable, Hashable {
    case fatLoss
    case strength
    case hypertrophy
    case endurance
    case performance
    case generalHealth
    case custom

    var displayName: String {
        switch self {
        case .fatLoss: return "Fat Loss"
        case .strength: return "Strength"
        case .hypertrophy: return "Hypertrophy"
        case .endurance: return "Endurance"
        case .performance: return "Performance"
        case .generalHealth: return "General Health"
        case .custom: return "Custom…"
        }
    }
}

enum Equipment: String, CaseIterable, Hashable {
    case gym, home, both, none

    var displayName: String {
        switch self {
        case .gym: return "Gym"
        case .home: return "Home"
        case .both: return "Both"
        case .none: return "None / Bodyweight"
        }
    }
}

#Preview {
    TrainerRequestTwoStepForm()
}
