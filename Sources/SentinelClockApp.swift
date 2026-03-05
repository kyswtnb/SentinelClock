import SwiftUI

@main
struct SentinelClockApp: App {
    @NSApplicationDelegateAdaptor(SentinelClockDelegate.self) var appDelegate
    
    var body: some Scene {
        // We use an empty window group just to satisfy SwiftUI requirement,
        // though NSApplicationDelegateAdaptor drives the main behavior.
        WindowGroup {
            EmptyView()
                .frame(width: 0, height: 0)
        }
    }
}
