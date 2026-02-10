import SwiftUI

struct TabBarButtons: View {
    let tab: AppRoleTabs
    @Binding var selection: AppRoleTabs
    @Environment(\.colorScheme) private var scheme

    private var active: Color { scheme == .dark ? .white : .black }
    private var inactive: Color { active.opacity(0.45) }

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
            .foregroundStyle(selection == tab ? active : inactive)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
