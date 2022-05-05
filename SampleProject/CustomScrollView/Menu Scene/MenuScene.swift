import SpriteKit

final class MenuScene: SKScene {
    
    // MARK: - Types
    
    enum Config {
        static let spriteSize = CGSize(width: 180, height: 180)
        static let scrollViewWidthAdjuster: CGFloat = 3
    }

    // MARK: - Properties
    
    var scrollView: SwiftySKScrollView?
    let moveableNode = SKNode()
    
    /// To register touches, make the sprite global.
    /// Could also give each sprite a name and than check for the name in the touches methods
    let sprite1Page1 = SKSpriteNode(color: .red, size: Config.spriteSize)
    
    private(set) lazy var clickLabel: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "HelveticaNeue")
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Tap"
        label.fontSize = 32
        label.position = CGPoint(x: 0, y: 0)
        return label
    }()
    
    // MARK: - Deinitialization
    
    deinit {
        print("Deinit GameScene")
    }
    
    // MARK: - Life Cycle
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        addChild(moveableNode)
        prepareVerticalScrolling()
        //prepareHorizontalScrolling()
    }
    
    override func willMove(from view: SKView) {
        scrollView?.removeFromSuperview()
        scrollView = nil
    }
    
    // MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if node == sprite1Page1 || node == clickLabel, scrollView?.isDisabled == false { // or check for spriteName  ->  if node.name == "SpriteName"
                loadGameScene()
            }
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

// MARK: - Private Methods

private extension MenuScene {
    func loadGameScene() {
        guard let scene = SKScene(fileNamed: GameViewController.SceneName.game.rawValue) else {
            fatalError("MenuScene cannot load GameScene.")
        }
        scene.scaleMode = .aspectFill
        let transition = SKTransition.crossFade(withDuration: 1)
        view?.presentScene(scene, transition: transition)
    }
}
