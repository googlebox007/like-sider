import UIKit
import Vision

class ScreenCaptureManager {
    static let shared = ScreenCaptureManager()
    
    private let ocrRequest = VNRecognizeTextRequest()
    
    private init() {
        configureOCR()
    }
    
    private func configureOCR() {
        ocrRequest.recognitionLevel = .accurate
        ocrRequest.usesLanguageCorrection = true
    }
    
    func captureScreen() -> UIImage? {
        guard let window = UIApplication.shared.windows.first else { return nil }
        
        let renderer = UIGraphicsImageRenderer(bounds: window.bounds)
        return renderer.image { context in
            window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
        }
    }
    
    func performOCR(on image: UIImage) async throws -> String {
        guard let cgImage = image.cgImage else {
            throw NSError(domain: "OCRError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image"])
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        try await requestHandler.perform([ocrRequest])
        
        guard let observations = ocrRequest.results else {
            return ""
        }
        
        return observations.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")
    }
}