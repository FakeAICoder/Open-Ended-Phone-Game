import XCTest
@testable import OpenEndedPhoneGame

final class GameManagerTests: XCTestCase {
    func testScoreIncrementsOnUpdate() {
        let manager = GameManager()
        let initialScore = manager.score
        manager.update()
        XCTAssertEqual(manager.score, initialScore + 1)
    }
}
