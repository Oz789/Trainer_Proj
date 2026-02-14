import SwiftUI

struct AuthHeaderView: View {
    let titleColor: Color

    var body: some View {
        Text("TRAINER")
            .font(.system(size: 38, weight: .bold))
            .foregroundColor(titleColor)
    }
}

#Preview {
    AuthHeaderView(titleColor: .white)
        .padding()
        .background(Color.black)
        .preferredColorScheme(.dark)
}
