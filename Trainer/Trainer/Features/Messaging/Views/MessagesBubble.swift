import SwiftUI

struct MessagesBubble: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme

    let message: ChatMessageModel

    private var t: ThemeTokens {
        themeManager.tokens(for: scheme)
    }

    private var bubbleAlignment: HorizontalAlignment {
        message.isFromCurrentUser ? .trailing : .leading
    }

    private var rowAlignment: Alignment {
        message.isFromCurrentUser ? .trailing : .leading
    }

    private var bubbleFillColor: Color {
        if message.isFromCurrentUser {
            return t.segmentedTint
        } else {
            return .black
        }
    }

    private var textColor: Color {
        .white
    }

    private var bubbleCorners: UnevenRoundedRectangle {
        if message.isFromCurrentUser {
            return UnevenRoundedRectangle(
                cornerRadii: .init(
                    topLeading: 18,
                    bottomLeading: 18,
                    bottomTrailing: 6,
                    topTrailing: 18
                )
            )
        } else {
            return UnevenRoundedRectangle(
                cornerRadii: .init(
                    topLeading: 18,
                    bottomLeading: 6,
                    bottomTrailing: 18,
                    topTrailing: 18
                )
            )
        }
    }

    var body: some View {
        VStack(alignment: bubbleAlignment, spacing: 4) {
            if !message.isFromCurrentUser, let senderName = message.senderName {
                Text(senderName)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 4)
            }

            Text(message.text)
                .font(.system(size: 16))
                .foregroundStyle(textColor)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    ZStack {
                        bubbleCorners
                            .fill(bubbleFillColor)

                        if !message.isFromCurrentUser {
                            bubbleCorners
                                .stroke(Color.white.opacity(0.16), lineWidth: 1)
                        }
                    }
                )

            Text(message.sentAt, style: .time)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.secondary)
                .padding(.horizontal, 4)
        }
        .frame(maxWidth: .infinity, alignment: rowAlignment)
        .padding(.horizontal, 14)
    }
}

struct TRMessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 16) {
                MessagesBubble(
                    message: ChatMessageModel(
                        text: "Hey, just checking in.",
                        isFromCurrentUser: false,
                        senderName: "Coach"
                    )
                )

                MessagesBubble(
                    message: ChatMessageModel(
                        text: "Everything feels good. I’ll send my check-in tonight.",
                        isFromCurrentUser: true
                    )
                )
            }
            .padding(.vertical, 20)
        }
        .preferredColorScheme(.dark)
    }
}
