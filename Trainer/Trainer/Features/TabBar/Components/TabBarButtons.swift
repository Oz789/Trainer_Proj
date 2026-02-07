import SwiftUI

struct TabBarButtons: View {
    let tab: AppRoleTabs
    @Binding var selection: AppRoleTabs

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.28, dampingFraction: 0.85)) {
                selection = tab
            }
        } label: {
            VStack(spacing: 6) {
                Image(systemName: tab.systemImage)
                    .font(.system(size: 16, weight: .medium))

                Text(tab.title)
                    .font(.caption2.weight(.medium))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 2)
            .foregroundStyle(selection == tab ? .white : .white.opacity(0.45))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
