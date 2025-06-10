import Foundation

final class Coordinator: GameManagerDelegate {
    private let gameManager = GameManager()
    func start() {
        gameManager.delegate = self
        for _ in 0..<5 {
            gameManager.update()
        }
    }

    func gameDidUpdateScore(_ manager: GameManager) {
        print("Score: \(manager.score)")
    }
}
