import SwiftUI

struct ClockView: View {
    @State private var currentTime = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // User Settings
    @AppStorage("fontStyle") private var fontStyle: ClockFont = .monospaced
    @AppStorage("showSeconds") private var showSeconds: Bool = true
    @AppStorage("dateFormat") private var dateFormat: DateFormatStyle = .ymd
    @AppStorage("textColor") private var textColor: Color = .primary
    @AppStorage("bgColor") private var bgColor: Color = Color(NSColor.windowBackgroundColor).opacity(0.85)
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.formatString
        return formatter
    }

    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = showSeconds ? "HH:mm:ss" : "HH:mm"
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 4) {
            if dateFormat != .none {
                Text(dateFormatter.string(from: currentTime))
                    .font(.system(size: 24, weight: .regular, design: fontStyle.design))
                    .foregroundColor(textColor)
                    .fixedSize(horizontal: true, vertical: false)
            }
            Text(timeFormatter.string(from: currentTime))
                .font(.system(size: 48, weight: .regular, design: fontStyle.design))
                .foregroundColor(textColor)
                .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(bgColor)
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
