import SwiftUI

struct RootMessagesView: View {
    @StateObject private var vm = TRMessagesViewModel()

    var body: some View {
        VStack(spacing: 0) {
            header 

            Divider()
                .overlay(Color.white.opacity(0.08))

            messagesList

            TRMessageComposerBar(
                text: $vm.draftMessage,
                onSendTapped: vm.sendMessage
            )
        }
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
    }

    private var header: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.white.opacity(0.12))
                .frame(width: 42, height: 42)
                .overlay(
                    Text(String(vm.participantName.prefix(1)))
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(vm.conversationTitle)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)

                Text("Online")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.green)
            }

            Spacer()

            Button {
                // future action
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .background(
                        Circle()
                            .fill(Color.white.opacity(0.08))
                    )
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 14)
        .padding(.bottom, 12)
    }

    private var messagesList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(vm.messages) { message in
                        MessagesBubble(message: message)
                            .id(message.id)
                    }
                }
                .padding(.vertical, 14)
            }
            .onAppear {
                scrollToBottom(with: proxy)
            }
            .onChange(of: vm.messages) { _ in
                scrollToBottom(with: proxy)
            }
        }
    }

    private func scrollToBottom(with proxy: ScrollViewProxy) {
        guard let lastID = vm.messages.last?.id else { return }

        DispatchQueue.main.async {
            withAnimation(.easeOut(duration: 0.22)) {
                proxy.scrollTo(lastID, anchor: .bottom)
            }
        }
    }
}


