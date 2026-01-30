import SwiftUI

struct GlassField: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme

    private var themeToken: ThemeTokens {
        themeManager.tokens(for: scheme)
    }


    let placeholder: String
    @Binding var text: String
    let isSecure: Bool

    @FocusState private var isFocused: Bool

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
        GlassField(placeholder: "Email", text: .constant(""), isSecure: false)
        GlassField(placeholder: "Password", text: .constant(""), isSecure: true)
    }
    .padding()
    .environmentObject(ThemeManager())
}
