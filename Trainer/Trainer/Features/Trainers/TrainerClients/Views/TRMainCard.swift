import SwiftUI

struct TRMainCard<Content: View>: View {
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    let shadowY: CGFloat
    let fill: Color
    let contentPadding: CGFloat
    @ViewBuilder let content: () -> Content

    init(
        cornerRadius: CGFloat = 28,
        shadowRadius: CGFloat = 18,
        shadowY: CGFloat = 14,
        fill: Color,
        contentPadding: CGFloat = 16,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.shadowY = shadowY
        self.fill = fill
        self.contentPadding = contentPadding
        self.content = content
    }

    var body: some View {
        content()
            .padding(contentPadding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(fill)
            )
            .compositingGroup() // avoids dark blending artifacts under shadows
            .shadow(color: .black.opacity(0.12), radius: shadowRadius, x: 0, y: shadowY)
    }
}

