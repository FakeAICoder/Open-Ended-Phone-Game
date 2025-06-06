#if canImport(SwiftUI) && canImport(SpriteKit)
import SpriteKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var player: SKShapeNode!
    private var gameStarted = false
    private var scoreLabel: SKLabelNode!
    private var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.systemBackground
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)
        physicsWorld.contactDelegate = self
        setupPlayer()
        setupScoreLabel()
    }

    func setupPlayer() {
        player = SKShapeNode(circleOfRadius: 20)
        player.fillColor = .systemBlue
        player.position = CGPoint(x: size.width * 0.3, y: size.height * 0.5)
        player.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = 1
        player.physicsBody?.contactTestBitMask = 2 | 4
        addChild(player)
    }

    func setupScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = .label
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 60)
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.text = "Score: 0"
        addChild(scoreLabel)
    }

    func spawnObstacle() {
        let obstacleWidth: CGFloat = 30
        let gapHeight: CGFloat = 120
        let maxY = size.height - gapHeight / 2
        let minY = gapHeight / 2
        let randomY = CGFloat.random(in: minY...maxY)

        let topHeight = size.height - randomY - gapHeight / 2
        let bottomHeight = randomY - gapHeight / 2

        let bottomRect = CGRect(x: size.width, y: 0, width: obstacleWidth, height: bottomHeight)
        let topRect = CGRect(x: size.width, y: size.height - topHeight, width: obstacleWidth, height: topHeight)

        let bottom = SKShapeNode(rect: bottomRect)
        bottom.fillColor = .systemGreen
        bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomRect)
        bottom.physicsBody?.categoryBitMask = 2
        bottom.physicsBody?.isDynamic = false

        let top = SKShapeNode(rect: topRect)
        top.fillColor = .systemGreen
        top.physicsBody = SKPhysicsBody(edgeLoopFrom: topRect)
        top.physicsBody?.categoryBitMask = 2
        top.physicsBody?.isDynamic = false

        let scoreNode = SKNode()
        scoreNode.position = CGPoint(x: size.width + obstacleWidth / 2, y: size.height / 2)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: size.height))
        scoreNode.physicsBody?.categoryBitMask = 4
        scoreNode.physicsBody?.isDynamic = false

        let moveAction = SKAction.moveBy(x: -size.width - obstacleWidth, y: 0, duration: 3)
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveAction, removeAction])

        bottom.run(sequence)
        top.run(sequence)
        scoreNode.run(sequence)

        addChild(bottom)
        addChild(top)
        addChild(scoreNode)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameStarted {
            gameStarted = true
            let spawn = SKAction.run { [weak self] in self?.spawnObstacle() }
            let delay = SKAction.wait(forDuration: 1.5)
            let spawnForever = SKAction.repeatForever(SKAction.sequence([spawn, delay]))
            run(spawnForever)
        }
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 25))
    }

    override func update(_ currentTime: TimeInterval) {
        if player.position.y < 0 || player.position.y > size.height {
            endGame()
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let categories = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if categories == (1 | 4) {
            score += 1
            if contact.bodyA.categoryBitMask == 4 {
                contact.bodyA.node?.removeFromParent()
            } else {
                contact.bodyB.node?.removeFromParent()
            }
        } else if categories & 2 != 0 && categories & 1 != 0 {
            endGame()
        }
    }

    func endGame() {
        removeAllActions()
        player.removeFromParent()
        run(SKAction.wait(forDuration: 0.5)) { [weak self] in
            self?.restartGame()
        }
    }

    func restartGame() {
        score = 0
        gameStarted = false
        removeAllChildren()
        didMove(to: view!)
    }
}
#endif
