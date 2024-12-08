import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack {
                ChatMessageList(messages: viewModel.messages)
                
                ChatInputView(message: $viewModel.currentMessage) {
                    await viewModel.sendMessage()
                }
            }
            .navigationTitle("Chat")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.clearChat()
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
    }
}

struct ChatMessageList: View {
    let messages: [ChatMessage]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(messages) { message in
                    ChatBubble(message: message)
                }
            }
            .padding()
        }
    }
}

struct ChatInputView: View {
    @Binding var message: String
    let onSend: () async -> Void
    
    var body: some View {
        HStack {
            TextField("Type a message...", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                Task {
                    await onSend()
                }
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.title2)
            }
            .disabled(message.isEmpty)
        }
        .padding()
    }
}