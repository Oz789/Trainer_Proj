import SwiftUI

struct TrainerPublicProfileView: View {
    /// Public trainer data returned from Discover search
    let trainer: TrainerPublic?

    /// Hook this up later to open your request form flow
    var onRequestTraining: (() -> Void)? = nil

    @Environment(\.colorScheme) private var scheme

    var body: some View {
        ZStack {
            background

            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    header

                    infoCard

                    requestCTA

                    Spacer(minLength: 24)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("Trainer")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Sections

    private var header: some View {
        VStack(spacing: 10) {
            Circle()
                .fill(.thinMaterial)
                .frame(width: 92, height: 92)
                .overlay(
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 46, weight: .semibold))
                        .foregroundStyle(.secondary)
                )

            Text(handleText)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)

            Text("Public Profile")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }

    private var infoCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About")
                .font(.headline.weight(.semibold))

            Text("This is the public trainer profile shown from Discover. Add bio, specialties, programs, pricing, etc. later.")
                .font(.footnote)
                .foregroundStyle(.secondary)

            Divider()
                .opacity(0.25)

            HStack {
                Label("Trainer", systemImage: "checkmark.seal.fill")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.secondary)

                Spacer()

                Text("Verified (later)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(.white.opacity(0.10), lineWidth: 1)
        )
    }

    private var requestCTA: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Work with this trainer")
                .font(.headline.weight(.semibold))

            Text("Send a coaching request with your goals and availability.")
                .font(.footnote)
                .foregroundStyle(.secondary)

            Button {
                onRequestTraining?()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "paperplane.fill")
                    Text("Request Training")
                        .font(.subheadline.weight(.semibold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .disabled(trainer == nil)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(.white.opacity(0.10), lineWidth: 1)
        )
    }

    // MARK: - Helpers

    private var handleText: String {
        guard let trainer else { return "@loading" }
        // Your TrainerPublic has `username` for sure
        return trainer.username.hasPrefix("@") ? trainer.username : "@\(trainer.username)"
    }

    private var background: some View {
        LinearGradient(
            colors: [
                Color.black,
                Color.black.opacity(scheme == .dark ? 0.94 : 0.90),
                Color.black.opacity(0.80)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        .overlay(
            RadialGradient(
                colors: [
                    Color.white.opacity(scheme == .dark ? 0.06 : 0.12),
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

#Preview("TrainerPublicProfileView (Dark)") {
    NavigationStack {
        TrainerPublicProfileView(trainer: nil) {
            print("Request Training tapped")
        }
    }
    .preferredColorScheme(.dark)
}
