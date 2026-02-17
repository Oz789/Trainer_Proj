import SwiftUI

struct UserProfileMainView: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 14) {
                    if session.isLoading {
                        ProgressView()
                            .tint(.white)
                        
                        Text("Loading profile…")
                            .font(.footnote)
                            .foregroundStyle(.white.opacity(0.7))

                    } else if let profile = session.profile {
                        ProfileSettingsButton()
                        Circle()
                            .fill(Color.white.opacity(0.10))
                            .frame(width: 92, height: 92)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 38, weight: .semibold))
                                    .foregroundStyle(.white.opacity(0.9))
                            )

                        Text(profile.displayName)
                            .font(.title2.bold())
                            .foregroundStyle(.white)

                        Text(profile.handle)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.70))

                        Text(profile.role.capitalized)
                            .font(.caption.weight(.semibold))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.white.opacity(0.10))
                            .clipShape(Capsule())
                            .foregroundStyle(.white.opacity(0.85))

                    } else {
                        Text("Profile not found")
                            .font(.headline)
                            .foregroundStyle(.white)

                        Button("Retry") {
                            Task { await session.refreshProfile() }
                        }
                        .font(.footnote.weight(.semibold))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(Color.white.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(.white)
                    }

                    Spacer()
                }
                .padding(.top, 24)
                .padding(.horizontal, 20)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                if session.isLoggedIn && session.profile == nil {
                    await session.refreshProfile()
                }
            }
        }
    }
}

#Preview {
    UserProfileMainView()
        .environmentObject(SessionManager())
        .preferredColorScheme(.dark)
}
