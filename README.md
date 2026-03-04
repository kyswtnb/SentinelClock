# SentinelClock

A minimalist macOS utility that displays a floating digital clock.

## Features
- Always‑on‑top window (NSPanel floating level)
- Semi‑transparent black background with rounded corners
- Dark/Light mode support
- Click‑through mode (ignore mouse events) and draggable when disabled
- Menu‑bar icon to toggle visibility and click‑through
- Built with SwiftUI for the clock UI and AppKit for the window handling

## Requirements
- macOS 11.0 or later
- Xcode command‑line tools (Swift compiler)

## Build & Run
```bash
# From the project root
make clean && make app   # builds SentinelClock.app in ./build
open build/SentinelClock.app
```

## Customization
- Adjust the font size or colors in `ClockView.swift`
- Change the panel size by editing the `contentRect` in `ClockPanel.swift`
- Toggle click‑through via the menu‑bar item "Enable Click‑through"

## License
MIT License – feel free to modify and redistribute.
