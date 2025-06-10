import Foundation

final class PlayingState: GameState {
    weak var manager: GameManager?

    init(manager: GameManager) {
        self.manager = manager
    }

    func enter() {
        print("Entering playing state")
    }

    func update() {
        // Game logic would go here
        NotificationCenter.default.post(name: GameManager.scoreDidChangeNotification, object: manager)
    }

    func exit() {
        print("Exiting playing state")
    }
}
