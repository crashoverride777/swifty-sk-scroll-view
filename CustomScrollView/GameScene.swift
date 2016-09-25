//
//  GameScene.swift
//  CustomScrollView
//
//  Created by Dominik on 09/01/2016.
//  Copyright (c) 2016 Dominik. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    /// Scroll view
    weak var scrollView: CustomScrollView?
    
    /// Moveable node in the scrollView
    fileprivate let moveableNode = SKNode()
    
    /// To register touches, make the sprite global.
    /// Could also give each sprite a name and than check for the name in the touches methods
    fileprivate let sprite1Page1 = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
    
    /// Click label
    fileprivate let clickLabel = SKLabelNode(fontNamed: "HelveticalNeue")
    
    deinit {
        print("Deinit game scene")
    }
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        // Add moveable node
        addChild(moveableNode)
        
        // VERTICAL SCROLLING
        //prepareVerticalScrolling()
        
        // HORIZONTAL SCROLLING
        prepareHorizontalScrolling()
    }
    
    /// Touches began,
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if node == sprite1Page1 || node == clickLabel { // or check for spriteName  ->  if node.name == "SpriteName"
                scrollView?.removeFromSuperview()
                let scene = MenuScene(size: size)
                scene.scaleMode = .aspectFill
                let transition = SKTransition.crossFade(withDuration: 1)
                view?.presentScene(scene, transition: transition)
            }
        }
    }
}

// MARK: - Vertical Scrolling

extension GameScene {

    func prepareVerticalScrolling() {
        
        // set up scrollView
        scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), moveableNode: moveableNode, scrollDirection: .vertical)
        
        guard let scrollView = scrollView else { return }
        
        scrollView.center = CGPoint(x: frame.midX, y: frame.midY)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height * 3) // * 3 makes it 3times as long as screen
        view?.addSubview(scrollView)

        // ScrollView Sprites for each page in scrollView
        // Makes positioning much easier.
        let page1ScrollView = SKSpriteNode(color: SKColor.clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.height))
        page1ScrollView.position = CGPoint(x: frame.midX, y: frame.midY)
        moveableNode.addChild(page1ScrollView)
        
        let page2ScrollView = SKSpriteNode(color: SKColor.clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.height))
        page2ScrollView.position = CGPoint(x: frame.midX, y: frame.midY - (frame.height))
        moveableNode.addChild(page2ScrollView)
        
        let page3ScrollView = SKSpriteNode(color: SKColor.clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.height))
        page3ScrollView.position = CGPoint(x: frame.midX, y: frame.midY - (frame.height * 2))
        moveableNode.addChild(page3ScrollView)
        
        // Test sprites page 1
        sprite1Page1.position = CGPoint(x: 0, y: 0)
        page1ScrollView.addChild(sprite1Page1)
        
        // Click label
        clickLabel.horizontalAlignmentMode = .center
        clickLabel.verticalAlignmentMode = .center
        clickLabel.text = "Tap"
        clickLabel.fontSize = 18
        clickLabel.position = CGPoint(x: 0, y: 0)
        sprite1Page1.addChild(clickLabel)
        
        // Test sprites page 1
        let sprite2Page1 = SKSpriteNode(color: SKColor.red, size: CGSize(width: 100, height: 100))
        sprite2Page1.position = CGPoint(x: sprite1Page1.position.x, y: sprite1Page1.position.y - sprite2Page1.size.height * 1.5)
        sprite1Page1.addChild(sprite2Page1)
        
        // Test sprites page 2
        let sprite1Page2 = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 100, height: 100))
        sprite1Page2.position = CGPoint(x: 0, y: 0)
        page2ScrollView.addChild(sprite1Page2)
        
        let sprite2Page2 = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 100, height: 100))
        sprite2Page2.position = CGPoint(x: sprite1Page2.position.x, y: sprite1Page2.position.y - (sprite2Page2.size.height * 1.5))
        sprite1Page2.addChild(sprite2Page2)
        
        /// Test sprites page 2
        let sprite1Page3 = SKSpriteNode(color: SKColor.green, size: CGSize(width: 100, height: 100))
        sprite1Page3.position = CGPoint(x: 0, y: 0)
        page3ScrollView.addChild(sprite1Page3)
        
        let sprite2Page3 = SKSpriteNode(color: SKColor.green, size: CGSize(width: 100, height: 100))
        sprite2Page3.position = CGPoint(x: sprite1Page3.position.x, y: sprite1Page3.position.y - (sprite2Page3.size.height * 1.5))
        sprite1Page3.addChild(sprite2Page3)
    }
}

// MARK: - Horizontal Scrolling

extension GameScene {
    
    func prepareHorizontalScrolling() {
        
        // Set up scrollView
        scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), moveableNode: moveableNode, scrollDirection: .horizontal)
        
        guard let scrollView = scrollView else { return }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width * 3, height: scrollView.frame.height) // * 3 makes it three times as wide as screen
        view?.addSubview(scrollView)
        
        // Set scrollView to first page
        scrollView.setContentOffset(CGPoint(x: 0 + frame.width * 2, y: 0), animated: true)
        
        // ScrollView Sprites for each page in scrollView
        // Makes positioning much easier.
        let page1ScrollView = SKSpriteNode(color: SKColor.clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.height))
        page1ScrollView.zPosition = -1
        page1ScrollView.position = CGPoint(x: frame.midX - (frame.width * 2), y: frame.midY)
        moveableNode.addChild(page1ScrollView)
        
        let page2ScrollView = SKSpriteNode(color: SKColor.clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.height))
        page2ScrollView.zPosition = -1
        page2ScrollView.position = CGPoint(x: frame.midX - (frame.width), y: frame.midY)
        moveableNode.addChild(page2ScrollView)
        
        let page3ScrollView = SKSpriteNode(color: SKColor.clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.height))
        page3ScrollView.zPosition = -1
        page3ScrollView.position = CGPoint(x: frame.midX, y: frame.midY)
        moveableNode.addChild(page3ScrollView)
        
        // Test sprites page 1
        sprite1Page1.position = CGPoint(x: 0, y: 0)
        page1ScrollView.addChild(sprite1Page1)
        
        // Click label
        clickLabel.horizontalAlignmentMode = .center
        clickLabel.verticalAlignmentMode = .center
        clickLabel.text = "Tap"
        clickLabel.fontSize = 26
        clickLabel.position = CGPoint(x: 0, y: 0)
        sprite1Page1.addChild(clickLabel)
        
        let sprite2Page1 = SKSpriteNode(color: SKColor.red, size: CGSize(width: 100, height: 100))
        sprite2Page1.position = CGPoint(x: sprite1Page1.position.x + (sprite2Page1.size.width * 1.5), y: sprite1Page1.position.y)
        sprite1Page1.addChild(sprite2Page1)
        
        // Test sprites page 2
        let sprite1Page2 = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 100, height: 100))
        sprite1Page2.position = CGPoint(x: 0, y: 0)
        page2ScrollView.addChild(sprite1Page2)
        
        let sprite2Page2 = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 100, height: 100))
        sprite2Page2.position = CGPoint(x: sprite1Page2.position.x + (sprite2Page2.size.width * 1.5), y: sprite1Page2.position.y)
        sprite1Page2.addChild(sprite2Page2)
        
        // Test sprites page 2
        let sprite1Page3 = SKSpriteNode(color: SKColor.green, size: CGSize(width: 100, height: 100))
        sprite1Page3.position = CGPoint(x: 0, y: 0)
        page3ScrollView.addChild(sprite1Page3)
        
        let sprite2Page3 = SKSpriteNode(color: SKColor.green, size: CGSize(width: 100, height: 100))
        sprite2Page3.position = CGPoint(x: sprite1Page3.position.x + (sprite2Page3.size.width * 1.5), y: sprite1Page3.position.y)
        sprite1Page3.addChild(sprite2Page3)
    }
}
