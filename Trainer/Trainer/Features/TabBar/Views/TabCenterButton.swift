import SwiftUI

struct TabCenterButton: View {
    let isSelected: Bool
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
                            .stroke(.white.opacity(isSelected ? 0.22 : 0.10), lineWidth: 1)
                    )

                Image(systemName: "person.fill")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TabCenterButton(isSelected: false, onTap: {})
        .padding()
        .background(Color.black)
}
