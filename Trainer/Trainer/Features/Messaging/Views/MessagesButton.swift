import SwiftUI

struct MessagesButton: View {
    var body: some View {
        NavigationLink(destination: RootMessagesView()) {
            Image(systemName: "bubble.right")
                .foregroundStyle(.white)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        MessagesButton()
    }
}
