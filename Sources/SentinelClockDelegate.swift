import AppKit
import SwiftUI

class SentinelClockDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var clockPanel: ClockPanel!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Setup NSPanel
        clockPanel = ClockPanel()
        
        let contentView = ClockView()
        
        let hostingView = NSHostingView(rootView: contentView)
        clockPanel.contentView = hostingView
        
        // Auto-size the window to fit the SwiftUI content
        let fittingSize = hostingView.fittingSize
        if let screen = NSScreen.main {
            let rect = screen.frame
            let x = (rect.width - fittingSize.width) / 2
            let y = (rect.height - fittingSize.height) / 2
            clockPanel.setFrame(NSRect(x: x, y: y, width: fittingSize.width, height: fittingSize.height), display: true)
        }
        
        clockPanel.makeKeyAndOrderFront(nil)
        
        // Setup Menu Bar Item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            // Using a simple system icon representing a clock/stopwatch or general widget
            button.image = NSImage(systemSymbolName: "clock", accessibilityDescription: "SentinelClock")
        }
        
        setupMenu()
    }
    
    func setupMenu() {
        let menu = NSMenu()
        
        let toggleVisibilityItem = NSMenuItem(title: "Hide Clock", action: #selector(toggleVisibility(_:)), keyEquivalent: "h")
        toggleVisibilityItem.target = self
        menu.addItem(toggleVisibilityItem)
        
        let clickThroughItem = NSMenuItem(title: "Enable Click-through", action: #selector(toggleClickThrough(_:)), keyEquivalent: "c")
        clickThroughItem.target = self
        menu.addItem(clickThroughItem)
        
        menu.addItem(NSMenuItem.separator())
        
        menu.addItem(NSMenuItem(title: "Quit SentinelClock", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    @objc func toggleVisibility(_ sender: NSMenuItem) {
        if clockPanel.isVisible {
            clockPanel.orderOut(nil)
            sender.title = "Show Clock"
        } else {
            clockPanel.makeKeyAndOrderFront(nil)
            sender.title = "Hide Clock"
        }
    }
    
    @objc func toggleClickThrough(_ sender: NSMenuItem) {
        clockPanel.isClickThrough.toggle()
        
        if clockPanel.isClickThrough {
            sender.title = "Disable Click-through"
        } else {
            sender.title = "Enable Click-through"
        }
    }
}
