import SwiftUI

struct TabCenterButton: View {
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.blue, Color.blue.opacity(0.55)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 38, height: 94)
                    .shadow(color: .blue.opacity(0.20), radius: 18, x: 0, y: 10)
                    .overlay(
                        Circle()
                            .stroke(.white.opacity(0.10), lineWidth: 1)
                    )

                Image(systemName: "rectangle")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
    }
}
