import SwiftUI

struct ClockView: View {
    @State private var currentTime = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }

    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 4) {
            Text(dateFormatter.string(from: currentTime))
                .font(.system(size: 24, weight: .regular, design: .monospaced))
                .foregroundColor(.primary)
                .fixedSize(horizontal: true, vertical: false)
            Text(timeFormatter.string(from: currentTime))
                .font(.system(size: 48, weight: .regular, design: .monospaced))
                .foregroundColor(.primary)
                .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(NSColor.windowBackgroundColor).opacity(0.85))
        )
        .onReceive(timer) { input in
            currentTime = input
        }
        // Add seamless dragging cursor feedback if not click-through
        .onHover { hovering in
            if hovering {
                NSCursor.openHand.push()
            } else {
                NSCursor.pop()
            }
        }
    }
}
