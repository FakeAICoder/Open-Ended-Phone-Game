#if canImport(SwiftUI) && canImport(SpriteKit)
import SwiftUI

@main
struct SkyDashApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
#else
@main
struct SkyDashCLI {
    static func main() {
        print("SkyDash requires SwiftUI and SpriteKit to run.")
    }
}
#endif
