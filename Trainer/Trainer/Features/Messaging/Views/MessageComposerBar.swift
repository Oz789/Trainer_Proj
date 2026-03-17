import SwiftUI

struct TRMessageComposerBar: View {
    @Binding var text: String
    let onSendTapped: () -> Void

    private var canSend: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text("Message...")
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                }

                TextEditor(text: $text)
                    .frame(minHeight: 24, maxHeight: 110)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .background(Color.clear)
            }
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white.opacity(0.08))
            )

            Button(action: onSendTapped) {
                Image(systemName: "arrow.up")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(canSend ? Color.blue : Color.white.opacity(0.12))
                    )
            }
            .disabled(!canSend)
        }
        .padding(.horizontal, 14)
        .padding(.top, 10)
        .padding(.bottom, 10)
        .background(.ultraThinMaterial)
    }
}

struct TRMessageComposerBar_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var text: String = ""

        var body: some View {
            ZStack(alignment: .bottom) {
                Color.black.ignoresSafeArea()

                TRMessageComposerBar(
                    text: $text,
                    onSendTapped: { }
                )
            }
            .preferredColorScheme(.dark)
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
