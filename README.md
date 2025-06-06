# SkyDash

SkyDash is a minimal endless runner game for iPhone built with **SwiftUI** and **SpriteKit**. Tap the screen to keep the ball in the air and dodge incoming obstacles. Each obstacle you pass increases your score. When you hit an obstacle or fly off screen, the game restarts.

## How to open the project

1. Open **Xcode** on your Mac.
2. Create a new *App* project using SwiftUI and SpriteKit templates, or simply an empty iOS project.
3. Replace the generated `App.swift`, `ContentView.swift`, and `GameScene.swift` files with the versions in `SkyDash/Sources/`.
4. Run on the iOS simulator or your device.

### Building on Linux

The repository includes a `Package.swift` to allow building the sources on Linux. The executable prints a message when the required Apple frameworks are missing:

```bash
swift build
./.build/debug/skydash
```
