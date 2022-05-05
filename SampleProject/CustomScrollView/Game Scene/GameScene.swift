import SpriteKit

final class GameScene: SKScene {
    
    // MARK: - Properties
    
    private var didTapScreen = false
    
    // MARK: - Life Cycle
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = SKColor.red
    }
    
    // MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard !didTapScreen else { return }
        didTapScreen = true
        
        if let view = view, let scene = SKScene(fileNamed: GameViewController.SceneName.menu.rawValue) {
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .crossFade(withDuration: 1))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
}
