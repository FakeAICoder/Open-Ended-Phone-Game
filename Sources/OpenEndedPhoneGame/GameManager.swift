import Foundation

protocol GameManagerDelegate: AnyObject {
    func gameDidUpdateScore(_ manager: GameManager)
}

final class GameManager {
    static let scoreDidChangeNotification = Notification.Name("scoreDidChange")

    weak var delegate: GameManagerDelegate?
    private(set) var score: Int = 0
    private var state: GameState?

    init() {
        transition(to: PlayingState(manager: self))
    }

    func transition(to newState: GameState) {
        state?.exit()
        state = newState
        state?.enter()
    }

    func update() {
        state?.update()
        score += 1
        delegate?.gameDidUpdateScore(self)
    }

    func pause() {
        transition(to: PausedState(manager: self))
    }

    func resume() {
        transition(to: PlayingState(manager: self))
    }
}
