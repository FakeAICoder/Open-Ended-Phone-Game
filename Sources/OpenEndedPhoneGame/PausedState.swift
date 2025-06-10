final class PausedState: GameState {
    weak var manager: GameManager?

    init(manager: GameManager) {
        self.manager = manager
    }

    func enter() {
        print("Game paused")
    }

    func update() {
        // Paused - do nothing
    }

    func exit() {
        print("Resume game")
    }
}
