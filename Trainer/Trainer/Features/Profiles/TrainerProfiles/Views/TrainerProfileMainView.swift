import SwiftUI

struct TrainerProfileMainView: View {
    @State private var selectedProgram: TrainerProgramCard? = nil
    @State private var showProgramOverlay = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 18) {

                        TProfileHeader(
                            profileImage: .init(systemName: "person.fill"),
                            displayName: "Oz",
                            username: "@oz_fit",
                            stats: [
                                .init(value: "128", label: "Workouts"),
                                .init(value: "1.2k", label: "Followers"),
                                .init(value: "450", label: "Following")
                            ]
                        )

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
                }

                // Fullscreen overlay 
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
    }
}



#Preview {
    let tm = ThemeManager()
    TrainerProfileMainView()
        .environmentObject(tm)
        .onAppear { tm.apply("theme.green") }
}
