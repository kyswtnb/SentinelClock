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
    @AppStorage("timeFontSize") private var timeFontSize: Double = 48
    @AppStorage("dateFontSize") private var dateFontSize: Double = 24

    @State private var isDragging: Bool = false
    @State private var dragStartFontSize: Double = 48
    @State private var dragStartDateSize: Double = 24
    
    struct SizeKey: PreferenceKey {
        static var defaultValue: CGSize = .zero
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
            value = nextValue()
        }
    }
    
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
                    .font(.system(size: CGFloat(dateFontSize), weight: .regular, design: fontStyle.design))
                    .foregroundColor(textColor)
                    .fixedSize(horizontal: true, vertical: false)
            }
            Text(timeFormatter.string(from: currentTime))
                .font(.system(size: CGFloat(timeFontSize), weight: .regular, design: fontStyle.design))
                .foregroundColor(textColor)
                .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(bgColor)
        )
        .background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: SizeKey.self, value: geo.size)
            }
        )
        .onPreferenceChange(SizeKey.self) { newSize in
            NotificationCenter.default.post(name: .clockSizeChanged, object: newSize)
        }
        .overlay(
            Image(systemName: "chevron.down.right")
                .foregroundColor(textColor.opacity(0.3))
                .font(.system(size: 10, weight: .semibold))
                .padding(6)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            if !isDragging {
                                isDragging = true
                                dragStartFontSize = timeFontSize
                                dragStartDateSize = dateFontSize
                            }
                            let delta = (value.translation.width + value.translation.height) / 2.0
                            let scale = 1.0 + delta / 150.0
                            timeFontSize = max(24, min(120, dragStartFontSize * scale))
                            dateFontSize = max(12, min(60, dragStartDateSize * scale))
                        }
                        .onEnded { _ in
                            isDragging = false
                        }
                )
                .onHover { hovering in
                    if hovering {
                        NSCursor.resizeUpDown.push()
                    } else {
                        NSCursor.pop()
                    }
                }
            , alignment: .bottomTrailing
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
