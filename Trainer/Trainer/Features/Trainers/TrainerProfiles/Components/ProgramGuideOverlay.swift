import SwiftUI

struct ProgramGuideOverlay: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme

    let program: TrainerProgramCard
    @Binding var isPresented: Bool

    @State private var pageIndex: Int = 0

    private var t: ThemeTokens { themeManager.tokens(for: scheme) }

    var body: some View {
        ZStack {
            Color.black
                .opacity(isPresented ? 0.55 : 0)
                .animation(.easeInOut(duration: 0.35), value: isPresented)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }

            VStack(spacing: 12) {
                header
                hero

                pager
                    .frame(height: 300)

                Spacer(minLength: 0)
            }
            .padding(.top, 12)
            .frame(maxWidth: .infinity)
            .background(sheetBackground.ignoresSafeArea())
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
            .padding(.top, 12)
            .transition(.move(edge: .bottom))
        }
    }

    private var sheetBackground: some View {
        Group {
            if scheme == .dark {
                LinearGradient(
                    colors: t.backgroundGradient,
                    startPoint: .top,
                    endPoint: .bottom
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(Color.white.opacity(0.04))
                )
            } else {
                Color(.systemGroupedBackground)
            }
        }
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Your \(program.title)")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(scheme == .dark ? t.titleColor : .black.opacity(0.88))

                Text("Care Guide")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(scheme == .dark ? t.textPrimary.opacity(0.70) : .black.opacity(0.55))
            }

            Spacer()

            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(scheme == .dark ? t.textPrimary.opacity(0.75) : .black.opacity(0.55))
                    .frame(width: 36, height: 36)
                    .background(
                        (scheme == .dark ? Color.white.opacity(0.08) : Color.black.opacity(0.06)),
                        in: Circle()
                    )
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 8)
    }

    private var hero: some View {
        RoundedRectangle(cornerRadius: 22, style: .continuous)
            .fill(scheme == .dark ? Color.white.opacity(0.06) : Color.black.opacity(0.06))
            .frame(height: 230)
            .padding(.horizontal, 18)
            .overlay(
                VStack {
                    Spacer()
                    Text("Hero image area")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(scheme == .dark ? t.textPrimary.opacity(0.45) : .black.opacity(0.35))
                    Spacer()
                }
            )
    }

    private var pager: some View {
        TabView(selection: $pageIndex) {
            ProgramGuidePageCard(
                number: "Week 01",
                title: "Push Routine",
                details: "Bench, Push-Ups, Etc..."
            )
            .tag(0)

            ProgramGuidePageCard(
                number: "02",
                title: "Strength Progression",
                details: "Increase load gradually. Track weekly volume and keep form clean to avoid stalls."
            )
            .tag(1)

            ProgramGuidePageCard(
                number: "03",
                title: "Recovery & Sleep",
                details: "Your gains are built outside the gym. Prioritize sleep and spacing hard sessions."
            )
            .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .padding(.horizontal, 18)
    }

    private func dismiss() {
        withAnimation(.spring(response: 0.45, dampingFraction: 0.9, blendDuration: 0.25)) {
            isPresented = false
        }
    }
}
