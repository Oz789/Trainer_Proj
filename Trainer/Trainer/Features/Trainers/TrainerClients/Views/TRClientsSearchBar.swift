import SwiftUI

struct TRClientsSearchBar: View {
    @Binding var text: String
    let placeholder: String

    @Environment(\.colorScheme) private var scheme

    private var bgFill: Color {
        scheme == .dark ? .white.opacity(0.06) : .black.opacity(0.05)
    }

    private var border: Color {
        scheme == .dark ? .white.opacity(0.10) : .black.opacity(0.10)
    }

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.secondary)

            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .foregroundStyle(.primary)
                .font(.subheadline.weight(.semibold))

            if !text.isEmpty {
                Button { text = "" } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(bgFill)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(border, lineWidth: 1)
        )
    }
}
