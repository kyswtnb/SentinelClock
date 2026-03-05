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
- macOS 13.0 or later
- Xcode command‑line tools (Swift compiler)

## Installation (Easy Way)
You can directly download the pre-built application from the [GitHub Releases](https://github.com/kyswtnb/SentinelClock/releases) page.
1. Download the latest `SentinelClock.zip`.
2. Unzip the file.
3. Move `SentinelClock.app` to your `/Applications` folder.
4. (Optional) In the app's Preferences, you can configure it to **Launch at Login**.

## Build & Run
```bash
# From the project root
make clean && make app   # builds SentinelClock.app in ./build
open build/SentinelClock.app
```

## Customization
- Open the **Preferences...** menu via the SentinelClock menu-bar icon (🕐)
- Customize the Font style, Show/Hide Seconds, Date format, Text Color, and Background Color.
- Adjust the panel behavior like `click-through` mode via the menu bar item.

## License
MIT License – feel free to modify and redistribute.

## Usage

To stop the clock, run:
```
pkill SentinelClock
```
