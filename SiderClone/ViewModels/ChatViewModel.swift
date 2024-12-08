import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var currentMessage: String = ""
    @Published var isLoading = false
    
    private let llmService: LLMServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(llmService: LLMServiceProtocol = LLMService()) {
        self.llmService = llmService
    }
    
    @MainActor
    func sendMessage() async {
        guard !currentMessage.isEmpty else { return }
        
        let userMessage = ChatMessage(
            id: UUID(),
            content: currentMessage,
            type: .user,
            timestamp: Date()
        )
        
        messages.append(userMessage)
        let messageToSend = currentMessage
        currentMessage = ""
        isLoading = true
        
        do {
            let response = try await llmService.sendMessage(messageToSend)
            messages.append(ChatMessage(
                id: UUID(),
                content: response,
                type: .assistant,
                timestamp: Date()
            ))
        } catch {
            // Handle error
            print("Error sending message: \(error)")
        }
        
        isLoading = false
    }
    
    func clearChat() {
        messages.removeAll()
    }
}