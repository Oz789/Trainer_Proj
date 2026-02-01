import SwiftUI

struct TProfileHeader: View {
    struct Stat: Identifiable {
        let id = UUID()
        let value: String
        let label: String
    }

    let profileImage: Image
    let displayName: String
    let username: String
    let stats: [Stat]

    var body: some View {
        VStack(spacing: 14) {
            profileImage
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
                .padding(18)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.06))
                        .overlay(
                            Circle().stroke(Color.white.opacity(0.10), lineWidth: 1)
                        )
                )

            VStack(spacing: 4) {
                Text(displayName)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.white)

                Text(username)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.55))
            }

            HStack(spacing: 22) {
                ForEach(stats) { s in
                    VStack(spacing: 2) {
                        Text(s.value)
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(.white)

                        Text(s.label)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.55))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 6)
        }
        .padding(.top, 18)
        .padding(.bottom, 8)
    }
}
