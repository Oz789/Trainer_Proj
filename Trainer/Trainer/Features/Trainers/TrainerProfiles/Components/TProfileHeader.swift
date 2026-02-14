import SwiftUI

struct TProfileHeader: View {
    struct Stat: Identifiable {
        let id = UUID()
        let value: String
        let label: String
    }

    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme

    let profileImage: Image
    let displayName: String
    let handle: String
    var stats: [Stat] = []

    private var t: ThemeTokens { themeManager.tokens(for: scheme) }
    private var avatarFill: Color {
        scheme == .dark ? Color.white.opacity(0.07) : Color.black.opacity(0.06)
    }
    private var avatarStroke: Color {
        scheme == .dark ? Color.white.opacity(0.08) : Color.clear
    }
    private var secondaryText: Color {
        t.textPrimary.opacity(scheme == .dark ? 0.60 : 0.55)
    }

    var body: some View {
        VStack(spacing: 14) {
            profileImage
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
                .padding(18)
                .background(
                    Circle()
                        .fill(avatarFill)
                        .overlay(
                            Circle().stroke(avatarStroke, lineWidth: 1)
                        )
                )
            VStack(spacing: 4) {
                Text(displayName)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(t.titleColor)

                Text(handle)
                    .font(.subheadline)
                    .foregroundStyle(secondaryText)
            }

            if !stats.isEmpty {
                HStack(spacing: 22) {
                    ForEach(stats) { s in
                        VStack(spacing: 2) {
                            Text(s.value)
                                .font(.headline.weight(.semibold))
                                .foregroundStyle(t.titleColor)

                            Text(s.label)
                                .font(.caption)
                                .foregroundStyle(secondaryText)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.top, 6)
            }
        }
        .padding(.top, 18)
        .padding(.bottom, 8)
    }
}

#Preview("Header Dark") {
    let tm = ThemeManager()
    tm.apply("theme.green")

    return ZStack {
        Color.black.ignoresSafeArea()
        TProfileHeader(
            profileImage: Image(systemName: "person.fill"),
            displayName: "Osvaldo Mosso",
            handle: "@oz_fit",
            stats: [
                .init(value: "128", label: "Workouts"),
                .init(value: "1.2k", label: "Followers"),
                .init(value: "450", label: "Following")
            ]
        )
        .padding()
    }
    .environmentObject(tm)
    .preferredColorScheme(.dark)
}

#Preview("Header Light") {
    let tm = ThemeManager()
    tm.apply("theme.green")

    return ZStack {
        Color.white.ignoresSafeArea()
        TProfileHeader(
            profileImage: Image(systemName: "person.fill"),
            displayName: "Osvaldo Mosso",
            handle: "@oz_fit",
            stats: [
                .init(value: "128", label: "Workouts"),
                .init(value: "1.2k", label: "Followers"),
                .init(value: "450", label: "Following")
            ]
        )
        .padding()
    }
    .environmentObject(tm)
    .preferredColorScheme(.light)
}
