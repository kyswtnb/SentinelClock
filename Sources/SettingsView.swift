import SwiftUI
import ServiceManagement

enum ClockFont: String, CaseIterable, Identifiable {
    case system = "System"
    case monospaced = "Monospaced"
    case serif = "Serif"
    case rounded = "Rounded"
    
    var id: String { self.rawValue }
    
    var design: Font.Design {
        switch self {
        case .system: return .default
        case .monospaced: return .monospaced
        case .serif: return .serif
        case .rounded: return .rounded
        }
    }
}

enum DateFormatStyle: String, CaseIterable, Identifiable {
    case ymd = "yyyy/MM/dd (EEE)"
    case dmy = "dd/MM/yyyy (EEE)"
    case mdy = "MM/dd/yyyy (EEE)"
    case full = "EEEE, d MMM yyyy"
    case none = "None (Hide)"
    
    var id: String { self.rawValue }
    
    var formatString: String {
        switch self {
        case .ymd: return "yyyy/MM/dd (EEE)"
        case .dmy: return "dd/MM/yyyy (EEE)"
        case .mdy: return "MM/dd/yyyy (EEE)"
        case .full: return "EEEE, d MMM yyyy"
        case .none: return ""
        }
    }
}

struct SettingsView: View {
    @AppStorage("fontStyle") private var fontStyle: ClockFont = .monospaced
    @AppStorage("showSeconds") private var showSeconds: Bool = true
    @AppStorage("dateFormat") private var dateFormat: DateFormatStyle = .ymd
    @AppStorage("textColor") private var textColor: Color = .primary
    @AppStorage("bgColor") private var bgColor: Color = Color(NSColor.windowBackgroundColor).opacity(0.85)
    @AppStorage("timeFontSize") private var timeFontSize: Double = 48
    @AppStorage("dateFontSize") private var dateFontSize: Double = 24
    @State private var launchAtLogin: Bool = SMAppService.mainApp.status == .enabled

    var body: some View {
        Form {
            Section {
                Toggle("Launch at Login", isOn: $launchAtLogin)
                    .onChange(of: launchAtLogin) { newValue in
                        do {
                            if newValue {
                                try SMAppService.mainApp.register()
                            } else {
                                try SMAppService.mainApp.unregister()
                            }
                        } catch {
                            print("Failed to update SMAppService: \(error)")
                            // Revert toggle if failed
                            launchAtLogin = SMAppService.mainApp.status == .enabled
                        }
                    }
            } header: {
                Text("System")
            }
            Divider()
            Section {
                Picker("Font", selection: $fontStyle) {
                    ForEach(ClockFont.allCases) { font in
                        Text(font.rawValue).tag(font)
                    }
                }
                
                Toggle("Show Seconds", isOn: $showSeconds)
                
                Picker("Date Format", selection: $dateFormat) {
                    ForEach(DateFormatStyle.allCases) { format in
                        Text(format.rawValue).tag(format)
                    }
                }
                
                Slider(value: $timeFontSize, in: 24...120, step: 1) {
                    Text("Time Font Size")
                } minimumValueLabel: {
                    Text("24")
                } maximumValueLabel: {
                    Text("120")
                }
                Text("Current: \(Int(timeFontSize)) pt")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Slider(value: $dateFontSize, in: 12...60, step: 1) {
                    Text("Date Font Size")
                } minimumValueLabel: {
                    Text("12")
                } maximumValueLabel: {
                    Text("60")
                }
                Text("Current: \(Int(dateFontSize)) pt")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } header: {
                Text("Appearance")
            }
            Divider()
            Section {
                ColorPicker("Text Color", selection: $textColor)
                ColorPicker("Background Color", selection: $bgColor)
            } header: {
                Text("Colors")
            }
        }
        .padding(20)
        .frame(width: 350)
    }
}
