import SwiftUI

struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.type == .user {
                Spacer()
            }
            
            VStack(alignment: message.type == .user ? .trailing : .leading) {
                Text(message.content)
                    .padding(12)
                    .background(message.type == .user ? Color.blue : Color.gray.opacity(0.2))
                    .foregroundColor(message.type == .user ? .white : .primary)
                    .cornerRadius(16)
                
                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            if message.type == .assistant {
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}