import Foundation

struct ChatMessageModel: Identifiable, Hashable {
    
    let id: UUID
    let text: String
    let sentAt: Date
    let isFromCurrentUser: Bool
    let senderName: String?
    
    
    init(
        id: UUID = UUID(),
        text: String,
        sentAt: Date = .now,
        isFromCurrentUser: Bool,
        senderName: String? = nil
    ) {
        self.id = id
        self.text = text
        self.sentAt = sentAt
        self.isFromCurrentUser = isFromCurrentUser
        self.senderName = senderName
    }
}

    // Mock chat for preview

extension ChatMessageModel {
    static let mockConversation: [ChatMessageModel] = [
        ChatMessageModel(
            text: "Hey, how are you feeling after yesterday’s workout?",
            sentAt: .now.addingTimeInterval(-3600),
            isFromCurrentUser: false,
            senderName: "Coach"
        ),
        ChatMessageModel(
            text: "Pretty good. Legs are dead though.",
            sentAt: .now.addingTimeInterval(-3300),
            isFromCurrentUser: true
        ),
        ChatMessageModel(
            text: "Perfect. That means we probably hit the right intensity. Make sure you get your steps in today too.",
            sentAt: .now.addingTimeInterval(-3000),
            isFromCurrentUser: false,
            senderName: "Coach"
        ),
        ChatMessageModel(
            text: "Got it. Do you want me to keep calories the same?",
            sentAt: .now.addingTimeInterval(-2600),
            isFromCurrentUser: true
        ),
        ChatMessageModel(
            text: "Yes, keep them the same for now.",
            sentAt: .now.addingTimeInterval(-2300),
            isFromCurrentUser: false,
            senderName: "Coach"
        )
    ]
}
