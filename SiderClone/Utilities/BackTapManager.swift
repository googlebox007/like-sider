import UIKit

class BackTapManager {
    static let shared = BackTapManager()
    
    private init() {}
    
    func setupBackTap() {
        guard let window = UIApplication.shared.windows.first else { return }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackTap))
        window.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleBackTap() {
        // Implement back tap functionality
    }
}