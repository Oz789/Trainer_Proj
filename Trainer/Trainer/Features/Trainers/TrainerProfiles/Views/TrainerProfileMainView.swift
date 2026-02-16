import SwiftUI

struct TrainerProfileMainView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var session: SessionManager
    @Environment(\.colorScheme) private var scheme

    @State private var selectedProgram: TrainerProgramCard? = nil
    @State private var showProgramOverlay = false

    private var t: ThemeTokens { themeManager.tokens(for: scheme) }
    var body: some View {
        ZStack {
            background

            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    if session.isLoading {
                        TProfileHeader(
                            profileImage: .init(systemName: "person.fill"),
                            displayName: "Loading…",
                            handle: "@loading",
                        )
                        .redacted(reason: .placeholder)
                    } else {
                        TProfileHeader(
                            profileImage: .init(systemName: "person.fill"),
                            displayName: session.profile?.displayName ?? "Trainer",
                            handle: session.profile?.handle ?? "@trainer"
                        )
                    }
                    Spacer().frame(height: 8)
                    TProfileProgramsInteractiveSection(
                        title: "Programs",
                        programs: TrainerProgramCard.mock
                    ) { program in
                        selectedProgram = program
                        withAnimation(.spring(response: 0.65, dampingFraction: 0.9, blendDuration: 0.30)) {
                            showProgramOverlay = true
                        }
                    }
                    Spacer(minLength: 10)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
                .padding(.top, 8)
            }
            if showProgramOverlay, let selectedProgram {
                ProgramGuideOverlay(
                    program: selectedProgram,
                    isPresented: $showProgramOverlay
                )
                .transition(.move(edge: .bottom))
                .zIndex(999)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ProfileSettingsButton()
            }
        }
    }

    private var background: some View {
        LinearGradient(
            colors: t.backgroundGradient,
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        .overlay(
            RadialGradient(
                colors: [
                    Color.black.opacity(scheme == .dark ? 0.45 : 0.10),
                    Color.clear
                ],
                center: .top,
                startRadius: 10,
                endRadius: 520
            )
            .blendMode(.overlay)
            .ignoresSafeArea()
        )
    }
}

#Preview("Trainer Profile (Dark)") {
    let tm = ThemeManager()
    tm.apply("theme.Cinder")
    let sm = SessionManager()
    return TrainerProfileMainView()
        .environmentObject(tm)
        .environmentObject(sm)
        .preferredColorScheme(.dark)
}

#Preview("Trainer Profile (Light)") {
    let tm = ThemeManager()
    tm.apply("theme.green")

    let sm = SessionManager()

    return TrainerProfileMainView()
        .environmentObject(tm)
        .environmentObject(sm)
        .preferredColorScheme(.light)
}
