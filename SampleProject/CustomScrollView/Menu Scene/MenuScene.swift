//
//  MenuScene.swift
//  SwiftySKScrollView
//
//  Created by Dominik on 09/01/2016.
//  Copyright (c) 2016 Dominik. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    // MARK: - Properties
    
    /// Sprite size
    let testSpriteSize = CGSize(width: 180, height: 180)
    
    /// Scroll view
    var scrollView: SwiftySKScrollView?
    let scrollViewWidthAdjuster: CGFloat = 3
    
    /// Moveable node in the scrollView
    let moveableNode = SKNode()
    
    /// To register touches, make the sprite global.
    /// Could also give each sprite a name and than check for the name in the touches methods
    let sprite1Page1 = SKSpriteNode(color: .red, size: CGSize(width: 180, height: 180))
    
    /// Click label
    let clickLabel: SKLabelNode = { 
        $0.horizontalAlignmentMode = .center
        $0.verticalAlignmentMode = .center
        $0.text = "Tap"
        $0.fontSize = 32
        $0.position = CGPoint(x: 0, y: 0)
        return $0
    }(SKLabelNode(fontNamed: "HelveticaNeue"))
    
    // MARK: - Deinit
    
    deinit {
        print("Deinit game scene")
    }
    
    // MARK: - View Life Cycle
    
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
    
    /// Touches began,
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if node == sprite1Page1 || node == clickLabel, scrollView?.isDisabled == false { // or check for spriteName  ->  if node.name == "SpriteName"
                loadGameScene()
            }
        }
    }
}

// MARK: - Load Game Scene

private extension MenuScene {
    
    func loadGameScene() {
        let scene = SKScene(fileNamed: GameViewController.Scene.game.rawValue)!
        scene.scaleMode = .aspectFill
        let transition = SKTransition.crossFade(withDuration: 1)
        view?.presentScene(scene, transition: transition)
    }
}
