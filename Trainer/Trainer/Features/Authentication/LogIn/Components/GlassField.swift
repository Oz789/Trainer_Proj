import SwiftUI

struct GlassField: View {
    let placeholder: String
    @Binding var text: String
    let isSecure: Bool

    var fill: Color = Color.white.opacity(0.10)
    var stroke: Color = Color.white.opacity(0.18)
    var placeholderColor: Color = Color.white.opacity(0.45)
    var textColor: Color = .white

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
                    .padding(.horizontal, 18)
            }

            if isSecure {
                SecureField("", text: $text)
                    .foregroundColor(textColor)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 18)
            } else {
                TextField("", text: $text)
                    .foregroundColor(textColor)
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
                .fill(fill)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(stroke, lineWidth: 1)
        )
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.black, .gray], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
        VStack(spacing: 14) {
            GlassField(placeholder: "Email", text: .constant(""), isSecure: false)
            GlassField(placeholder: "Password", text: .constant(""), isSecure: true)
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
