import SwiftUI

struct GlassField: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var theme: AppTheme { themeManager.theme }

    let placeholder: String
    @Binding var text: String
    let isSecure: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(theme.textSecondary)
                    .padding(.horizontal, 18)
            }

            if isSecure {
                SecureField("", text: $text)
                    .foregroundColor(theme.textPrimary)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 18)
            } else {
                TextField("", text: $text)
                    .foregroundColor(theme.textPrimary)
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
                .fill(theme.fieldFill)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(theme.fieldStroke, lineWidth: 1)
        )
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 14) {
            GlassField(placeholder: "Email", text: .constant(""), isSecure: false)
            GlassField(placeholder: "Password", text: .constant(""), isSecure: true)
        }
        .padding()
    }
    .environmentObject(ThemeManager())
    .preferredColorScheme(.dark)
}
