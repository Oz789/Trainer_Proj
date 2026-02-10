import SwiftUI

struct TabCenterButton: View {
    let isSelected: Bool
    let onTap: () -> Void

    @Environment(\.colorScheme) private var scheme

    private var foreground: Color { scheme == .dark ? .white : .black }
    private var strokeColor: Color { foreground.opacity(isSelected ? 0.22 : 0.12) }

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
                    .shadow(color: .blue.opacity(scheme == .dark ? 0.20 : 0.12),
                            radius: 18, x: 0, y: 10)
                    .overlay(
                        Circle()
                            .stroke(strokeColor, lineWidth: 1)
                    )

                Image(systemName: "person.fill")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(foreground)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview("Light") {
    TabCenterButton(isSelected: false, onTap: {})
        .padding()
        .background(Color.white)
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    TabCenterButton(isSelected: true, onTap: {})
        .padding()
        .background(Color.black)
        .preferredColorScheme(.dark)
}
