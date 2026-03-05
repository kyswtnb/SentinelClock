# SentinelClock

[日本語 (Japanese)](#日本語) | [English](#english)

---

<a id="日本語"></a>
# 日本語 🇯🇵

シンプルで常時最前面に表示される、macOS向けのフローティング・デジタル時計アプリです。

## 主な機能
- 常に最前面に表示（NSPanelを利用）
- 半透明の黒背景と角丸デザイン
- ダークモード・ライトモード対応
- クリックスルー機能（マウス操作を無視するモード）、およびドラッグ移動
- メニューバーからの表示切り替えや設定管理
- SwiftUI（UI）とAppKit（ウィンドウ管理）による構築

## 必須環境
- macOS 13.0 以降
- Xcodeコマンドラインツール（Swiftコンパイラ） ※ソースからビルドする場合

## インストール（簡単な方法）
完成済みのアプリを [GitHub Releases](https://github.com/kyswtnb/SentinelClock/releases) ページから直接ダウンロードできます。
1. 最新の `SentinelClock.zip` をダウンロードします。
2. ZIPファイルを解凍します。
3. `SentinelClock.app` を `/Applications` （アプリケーション）フォルダに移動します。
4. （オプション）アプリの環境設定（Preferences）から「**Launch at Login**（ログイン時に開く）」を有効化できます。

### インストール時のトラブルシューティング
このアプリはApple Developerアカウントで署名・公証されていないため、macOSのセキュリティ機能（Gatekeeper）によって _"悪質なソフトウェアかどうかをAppleでは確認できないため、このソフトウェアは開けません"_ といった警告が出ることがあります。

これを回避してアプリを起動するには、以下の手順を行ってください：
1. Finderで **アプリケーション** フォルダを開きます。
2. `SentinelClock.app` を **右クリック**（またはControlキーを押しながらクリック）し、**「開く」** を選択します。
3. 再度警告ダイアログが出ますが、今度は **「開く」** ボタンが表示されるので、それをクリックします。
※ この操作は最初の1回だけでOKです。

または、ターミナルから以下のコマンドを実行して隔離属性（Quarantine）を削除することもできます：
```bash
xattr -cr /Applications/SentinelClock.app
```

## ビルドと実行
```bash
# プロジェクトのルートディレクトリで実行
make clean && make app   # ./build 内に SentinelClock.app が生成されます
open build/SentinelClock.app
```

## カスタマイズと設定
- メニューバーのアイコン（🕐）から **Preferences...** を開きます。
- フォントスタイル、秒数の表示/非表示、日付フォーマット、テキストカラー、背景色を自由に変更可能です。
- メニューバーアイコンから「Enable Click‑through」を選ぶと、時計をクリック貫通状態にできます。

## ライセンス
MIT License – 自由に変更・再配布可能です。

## 使用方法
終了するには、メニューバーから「Quit SentinelClock」を選ぶか、ターミナルで以下を実行します：
```bash
pkill SentinelClock
```

---

<a id="english"></a>
# English 🇺🇸

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
- Xcode command‑line tools (Swift compiler) if building from source

## Installation (Easy Way)
You can directly download the pre-built application from the [GitHub Releases](https://github.com/kyswtnb/SentinelClock/releases) page.
1. Download the latest `SentinelClock.zip`.
2. Unzip the file.
3. Move `SentinelClock.app` to your `/Applications` folder.
4. (Optional) In the app's Preferences, you can configure it to **Launch at Login**.

### Troubleshooting Installation
Because this app is not signed with an Apple Developer account, macOS Gatekeeper might show a warning such as _"SentinelClock is damaged and can't be opened"_ or _"macOS cannot verify that this app is free from malware"_.

To bypass this and run the app:
1. Open your **Applications** folder in Finder.
2. **Right-click (or Control-click)** on `SentinelClock.app` and select **Open**.
3. A similar dialog will appear, but this time it will have an **Open** button. Click it to launch the app.
*(You only need to do this the very first time you open the app).*

Alternatively, you can remove the quarantine attribute via Terminal:
```bash
xattr -cr /Applications/SentinelClock.app
```

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
To stop the clock, use the menu bar icon to quit, or run:
```bash
pkill SentinelClock
```
