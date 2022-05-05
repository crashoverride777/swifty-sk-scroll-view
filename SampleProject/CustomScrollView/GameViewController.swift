import UIKit
import SpriteKit

final class GameViewController: UIViewController {
    enum SceneName: String {
        case menu = "MenuScene"
        case game = "GameScene"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = self.view as! SKView
        if let scene = SKScene(fileNamed: SceneName.menu.rawValue) {
            // Configure the view.
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
        }
    }

    override var shouldAutorotate: Bool {
        true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
}
