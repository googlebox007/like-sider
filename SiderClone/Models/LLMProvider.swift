import Foundation

enum LLMProvider: String, CaseIterable, Identifiable {
    case openAI = "OpenAI"
    case anthropic = "Anthropic"
    case gemini = "Google Gemini"
    case custom = "Custom"
    
    var id: String { rawValue }
    
    var baseURL: URL {
        switch self {
        case .openAI:
            return URL(string: "https://api.openai.com/v1")!
        case .anthropic:
            return URL(string: "https://api.anthropic.com/v1")!
        case .gemini:
            return URL(string: "https://generativelanguage.googleapis.com/v1")!
        case .custom:
            // Return from user settings
            return URL(string: "https://api.custom.ai")!
        }
    }
}