import AppKit
import SwiftUI

class ClockPanel: NSPanel {
    var isClickThrough: Bool = false {
        didSet {
            self.ignoresMouseEvents = isClickThrough
            self.alphaValue = isClickThrough ? 0.7 : 1.0
        }
    }
    
    init() {
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: 700, height: 120),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        
        // Floating window always on top
        self.level = .floating
        
        // Appear on all spaces/desktops
        self.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
        
        self.isOpaque = false
        self.backgroundColor = .clear
        self.hasShadow = true
        self.isMovableByWindowBackground = true // Crucial to allow dragging without a title bar
        
        // Prevent window from receiving key events but keep it able to respond to mouse events
        self.ignoresMouseEvents = false
    }
    
    // Allows window dragging even for NSView subclasses that might intercept mouse down
    override var canBecomeKey: Bool {
        return false
    }
    
    override var canBecomeMain: Bool {
        return false
    }
}
