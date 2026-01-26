import SwiftUI

struct PrimaryCTAButton: View {
    let title: String
    var gradient: [Color]
    var height: CGFloat = 54
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: 320)
                .frame(height: height)
                .background(
                    LinearGradient(colors: gradient, startPoint: .leading, endPoint: .trailing)
                )
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .shadow(color: .black.opacity(0.35), radius: 14, x: 0, y: 10)
        }
    }
}

#Preview {
    PrimaryCTAButton(
        title: "Log In",
        gradient: [
            Color(red: 0.68, green: 0.32, blue: 0.98),
            Color(red: 1.00, green: 0.27, blue: 0.45)
        ]
    ) {}
    .padding()
    .background(Color.black)
    .preferredColorScheme(.dark)
}
