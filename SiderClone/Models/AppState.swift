import Foundation
import Combine

class AppState: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentProvider: LLMProvider = .openAI
    @Published var isProcessing = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupObservers()
    }
    
    private func setupObservers() {
        // Add observers for system notifications
        NotificationCenter.default
            .publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { [weak self] _ in
                self?.checkAuthenticationStatus()
            }
            .store(in: &cancellables)
    }
    
    private func checkAuthenticationStatus() {
        // Implement authentication check
    }
}