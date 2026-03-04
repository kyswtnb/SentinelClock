import SwiftUI

@main
struct SentinelClockApp: App {
    @NSApplicationDelegateAdaptor(SentinelClockDelegate.self) var appDelegate
    
    var body: some Scene {
        // We use an empty Settings window to satisfy SwiftUI's Scene requirement cleanly
        // Alternatively, use WindowGroup with empty view
        Settings {
            EmptyView()
        }
    }
}
