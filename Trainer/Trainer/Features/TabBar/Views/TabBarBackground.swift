import SwiftUI

struct TabBarBackground: View {
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.white.opacity(0.10))
                .frame(height: 0.2)
        }
    }
}
