import SwiftUI

struct TabBarBackground: View {
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(scheme == .dark ? Color.black : Color.white)
            Rectangle()
                .fill((scheme == .dark ? Color.white : Color.black).opacity(0.12))
                .frame(height: 0.5)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}
