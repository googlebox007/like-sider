import Foundation

struct ChatMessage: Identifiable, Codable {
    let id: UUID
    let content: String
    let type: MessageType
    let timestamp: Date
    
    enum MessageType: String, Codable {
        case user
        case assistant
        case system
    }
}