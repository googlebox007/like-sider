import Foundation
import Combine

class SettingsManager: ObservableObject {
    @Published var apiKeys: [LLMProvider: String] = [:]
    @Published var customEndpoint: URL?
    @Published var selectedModel: String = "gpt-4"
    @Published var temperature: Double = 0.7
    
    private let defaults = UserDefaults.standard
    private let keysKey = "llm_api_keys"
    
    init() {
        loadSettings()
    }
    
    func saveAPIKey(_ key: String, for provider: LLMProvider) {
        apiKeys[provider] = key
        saveSettings()
    }
    
    func getAPIKey(for provider: LLMProvider) -> String? {
        return apiKeys[provider]
    }
    
    private func loadSettings() {
        if let data = defaults.data(forKey: keysKey),
           let decoded = try? JSONDecoder().decode([LLMProvider: String].self, from: data) {
            apiKeys = decoded
        }
    }
    
    private func saveSettings() {
        if let encoded = try? JSONEncoder().encode(apiKeys) {
            defaults.set(encoded, forKey: keysKey)
        }
    }
}