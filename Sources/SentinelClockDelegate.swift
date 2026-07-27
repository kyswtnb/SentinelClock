import AppKit
import SwiftUI

extension Notification.Name {
    static let clockSizeChanged = Notification.Name("clockSizeChanged")
}

class SentinelClockDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var clockPanel: ClockPanel!
    var settingsWindow: NSWindow?
    
    func applicationShouldOpenUntitledFile(_ sender: NSApplication) -> Bool {
        return false
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Setup NSPanel
        clockPanel = ClockPanel()
        
        let contentView = ClockView()
        let hostingView = NSHostingView(rootView: contentView)
        clockPanel.contentView = hostingView
        
        // Listen to size changes
        NotificationCenter.default.addObserver(self, selector: #selector(handleSizeChange(_:)), name: .clockSizeChanged, object: nil)
        
        // Auto-size the window to fit the SwiftUI content initially
        resizePanel(to: hostingView.fittingSize)
        
        clockPanel.makeKeyAndOrderFront(nil)
        
        // Setup Menu Bar Item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            // Using a simple system icon representing a clock/stopwatch or general widget
            button.image = NSImage(systemSymbolName: "clock", accessibilityDescription: "SentinelClock")
        }
        
        setupMenu()
    }
    
    private func resizePanel(to size: CGSize) {
        guard let screen = NSScreen.main else { return }
        
        let currentFrame = clockPanel.frame
        let newWidth = size.width
        let newHeight = size.height
        
        // Detect if initial frame configuration (default window size in ClockPanel is 700x120)
        let isInitial = currentFrame.width == 700 && currentFrame.height == 120
        
        let newX: CGFloat
        let newY: CGFloat
        
        if isInitial {
            let rect = screen.frame
            newX = (rect.width - newWidth) / 2
            newY = (rect.height - newHeight) / 2
        } else {
            // Keep the window centered relative to its current screen position
            newX = currentFrame.midX - newWidth / 2
            newY = currentFrame.midY - newHeight / 2
        }
        
        clockPanel.setFrame(NSRect(x: newX, y: newY, width: newWidth, height: newHeight), display: true, animate: false)
    }
    
    @objc private func handleSizeChange(_ notification: Notification) {
        guard let size = notification.object as? CGSize else { return }
        DispatchQueue.main.async { [weak self] in
            self?.resizePanel(to: size)
        }
    }
    
    func setupMenu() {
        let menu = NSMenu()
        
        let toggleVisibilityItem = NSMenuItem(title: "Hide Clock", action: #selector(toggleVisibility(_:)), keyEquivalent: "h")
        toggleVisibilityItem.target = self
        menu.addItem(toggleVisibilityItem)
        
        menu.addItem(NSMenuItem.separator())
        
        let preferencesItem = NSMenuItem(title: "Preferences...", action: #selector(openPreferences(_:)), keyEquivalent: ",")
        preferencesItem.target = self
        menu.addItem(preferencesItem)
        
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
    
    @objc func openPreferences(_ sender: NSMenuItem) {
        if settingsWindow == nil {
            let hostingController = NSHostingController(rootView: SettingsView())
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 350, height: 400),
                styleMask: [.titled, .closable],
                backing: .buffered,
                defer: false
            )
            window.title = "Preferences"
            window.contentViewController = hostingController
            window.center()
            window.isReleasedWhenClosed = false
            settingsWindow = window
        }
        
        NSApp.activate(ignoringOtherApps: true)
        settingsWindow?.makeKeyAndOrderFront(nil)
    }
}
