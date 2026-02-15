import SwiftUI

struct MainAppView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var sessionManager: SessionManager

    @State private var role: AppUserRoles? = nil
    @State private var isLoadingProfile = true
    @State private var errorMessage: String? = nil

    private let profileService = ProfileService()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if isLoadingProfile {
                ProgressView()
                    .tint(.white)
            } else if let role {
                MainTabContainerView(role: role)
                    .environmentObject(themeManager)
            } else {
                VStack(spacing: 10) {
                    Text("Couldn’t load your profile")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white)

                    if let errorMessage {
                        Text(errorMessage)
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.6))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }

                    Button("Try Again") {
                        Task { await loadRole() }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .task {
            await loadRole()
        }
    }

    private func loadRole() async {
        isLoadingProfile = true
        errorMessage = nil
        defer { isLoadingProfile = false }

        guard sessionManager.session != nil else {
            role = nil
            errorMessage = "No active session."
            return
        }

        do {
            let profile = try await profileService.fetchMyProfile()
            role = (profile.role.lowercased() == "trainer") ? .trainer : .client
        } catch {
            role = nil
            errorMessage = error.localizedDescription
        }
    }
}

#Preview("MainAppView (Trainer)") {
    MainTabContainerView(role: .trainer)
        .environmentObject(ThemeManager())
}
