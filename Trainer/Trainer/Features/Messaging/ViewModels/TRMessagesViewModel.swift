import Foundation
import SwiftUI

@MainActor
final class TRMessagesViewModel: ObservableObject {
    @Published var messages: [ChatMessageModel]
    @Published var draftMessage: String = ""

    let conversationTitle: String
    let participantName: String

    init(
        conversationTitle: String = "Coach Carter",
        participantName: String = "Coach Carter",
        messages: [ChatMessageModel] = ChatMessageModel.mockConversation
    ) {
        self.conversationTitle = conversationTitle
        self.participantName = participantName
        self.messages = messages
    }

    func sendMessage() {
        let trimmed = draftMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let newMessage = ChatMessageModel(
            text: trimmed,
            sentAt: .now,
            isFromCurrentUser: true
        )

        messages.append(newMessage)
        draftMessage = ""
    }

    func receiveMockReply() {
        let reply = ChatMessageModel(
            text: "Sounds good. Let’s stay consistent this week.",
            sentAt: .now,
            isFromCurrentUser: false,
            senderName: participantName
        )

        messages.append(reply)
    }
}
