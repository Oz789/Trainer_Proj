import SwiftUI

struct AuthTextField: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme
    @FocusState private var isFocused: Bool
    @Binding var text: String
    private var themeToken: ThemeTokens { themeManager.tokens(for: scheme) }
    let placeholder: String
    let isSecure: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(themeToken.fieldPlaceholder)
                    .padding(.horizontal, 18)
            }

            if isSecure {
                SecureField("", text: $text)
                    .focused($isFocused)
                    .foregroundColor(themeToken.fieldText)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 18)
            } else {
                TextField("", text: $text)
                    .focused($isFocused)
                    .foregroundColor(themeToken.fieldText)
                    .keyboardType(placeholder.lowercased().contains("email") ? .emailAddress : .default)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 18)
            }
        }
        .frame(maxWidth: 320)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(themeToken.fieldFill)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(isFocused ? themeToken.fieldStrokeFocused : themeToken.fieldStroke, lineWidth: 2)
        )
    }
}

#Preview("GlassField") {
    VStack(spacing: 14) {
        AuthTextField(text: .constant(""), placeholder: "Email", isSecure: false)
        AuthTextField(text: .constant(""), placeholder: "Password", isSecure: true)
    }
    .padding()
    .environmentObject(ThemeManager())
}
