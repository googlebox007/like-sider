import SwiftUI

@main
struct SiderCloneApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var settingsManager = SettingsManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(settingsManager)
        }
    }
}