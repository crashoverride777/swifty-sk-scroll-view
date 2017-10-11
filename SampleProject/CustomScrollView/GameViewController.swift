//
//  GameViewController.swift
//  SwiftySKScrollView
//
//  Created by Dominik on 09/01/2016.
//  Copyright (c) 2016 Dominik. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    enum Scene: String {
        case menu = "MenuScene"
        case game = "GameScene"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = self.view as! SKView
        let scene = SKScene(fileNamed: Scene.menu.rawValue)!
        // Configure the view.
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
