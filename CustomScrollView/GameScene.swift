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
    weak var scrollView: CustomScrollView!
    
    /// Moveable node in the scrollView
    let moveableNode = SKNode()
    
    /// To register touches, make the sprite global.
    /// Could also give each sprite a name and than check for the name in the touches methods
    var sprite1Page1: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /// add moveable node
        addChild(moveableNode)
        
        
        /// VERTICAL SCROLLING
        //prepareVerticalScrolling()
        
        
        /// HORIZONTAL SCROLLING
        prepareHorizontalScrolling()
        
    }
    
    // MARK: - Vertical scrolling properties
    func prepareVerticalScrolling() {
        
        /// set up scrollView
        scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), scene: self, moveableNode: moveableNode, scrollDirection: .Vertical)
        scrollView.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height * 3) // * 3 makes it 3times as long as screen
        view!.addSubview(scrollView)

        /// ScrollView Sprites for each page in scrollView
        /// Makes positioning much easier.
        let page1ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height))
        page1ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        moveableNode.addChild(page1ScrollView)
        
        let page2ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height))
        page2ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - (self.frame.size.height))
        moveableNode.addChild(page2ScrollView)
        
        let page3ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height))
        page3ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - (self.frame.size.height * 2))
        moveableNode.addChild(page3ScrollView)
        
        /// Test sprites page 1
        sprite1Page1 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
        sprite1Page1.position = CGPointMake(0, 0)
        page1ScrollView.addChild(sprite1Page1)
        
        let sprite2Page1 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
        sprite2Page1.position = CGPointMake(sprite1Page1.position.x, sprite1Page1.position.y - sprite2Page1.size.height * 1.5)
        sprite1Page1.addChild(sprite2Page1)
        
        /// Test sprites page 2
        let sprite1Page2 = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: 50, height: 50))
        sprite1Page2.position = CGPointMake(0, 0)
        page2ScrollView.addChild(sprite1Page2)
        
        let sprite2Page2 = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: 50, height: 50))
        sprite2Page2.position = CGPointMake(sprite1Page2.position.x, sprite1Page2.position.y - (sprite2Page2.size.height * 1.5))
        sprite1Page2.addChild(sprite2Page2)
        
        /// Test sprites page 2
        let sprite1Page3 = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 50, height: 50))
        sprite1Page3.position = CGPointMake(0, 0)
        page3ScrollView.addChild(sprite1Page3)
        
        let sprite2Page3 = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 50, height: 50))
        sprite2Page3.position = CGPointMake(sprite1Page3.position.x, sprite1Page3.position.y - (sprite2Page3.size.height * 1.5))
        sprite1Page3.addChild(sprite2Page3)
    }
    
    
    
    // MARK: - Horizontal scrolling properties
    func prepareHorizontalScrolling() {
        
        /// Set up scrollView
        scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), scene: self, moveableNode: moveableNode, scrollDirection: .Horizontal)
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height) // * 3 makes it three times as wide as screen
        view!.addSubview(scrollView)
        
        /// Set scrollView to first page
        scrollView.setContentOffset(CGPoint(x: 0 + self.frame.size.width * 2, y: 0), animated: true)
        
        /// ScrollView Sprites for each page in scrollView
        /// Makes positioning much easier.
        let page1ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height))
        page1ScrollView.zPosition = -1
        page1ScrollView.position = CGPointMake(CGRectGetMidX(self.frame) - (self.frame.size.width * 2), CGRectGetMidY(self.frame))
        moveableNode.addChild(page1ScrollView)
        
        let page2ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height))
        page2ScrollView.zPosition = -1
        page2ScrollView.position = CGPointMake(CGRectGetMidX(self.frame) - (self.frame.size.width), CGRectGetMidY(self.frame))
        moveableNode.addChild(page2ScrollView)
        
        let page3ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height))
        page3ScrollView.zPosition = -1
        page3ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        moveableNode.addChild(page3ScrollView)
        
        /// Test sprites page 1
        sprite1Page1 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
        sprite1Page1.position = CGPointMake(0, 0)
        page1ScrollView.addChild(sprite1Page1)
        
        let sprite2Page1 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
        sprite2Page1.position = CGPointMake(sprite1Page1.position.x + (sprite2Page1.size.width * 1.5), sprite1Page1.position.y)
        sprite1Page1.addChild(sprite2Page1)
        
        /// Test sprites page 2
        let sprite1Page2 = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: 50, height: 50))
        sprite1Page2.position = CGPointMake(0, 0)
        page2ScrollView.addChild(sprite1Page2)
        
        let sprite2Page2 = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: 50, height: 50))
        sprite2Page2.position = CGPointMake(sprite1Page2.position.x + (sprite2Page2.size.width * 1.5), sprite1Page2.position.y)
        sprite1Page2.addChild(sprite2Page2)
        
        /// Test sprites page 2
        let sprite1Page3 = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 50, height: 50))
        sprite1Page3.position = CGPointMake(0, 0)
        page3ScrollView.addChild(sprite1Page3)
        
        let sprite2Page3 = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 50, height: 50))
        sprite2Page3.position = CGPointMake(sprite1Page3.position.x + (sprite2Page3.size.width * 1.5), sprite1Page3.position.y)
        sprite1Page3.addChild(sprite2Page3)
    }
    
    /// Touches began,
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        for touch in touches {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
        
            if node == sprite1Page1 { // or check for spriteName  ->  if node.name == "SpriteName"
                print("Sprite 1 on page 1 has been pressed")
                scrollView?.removeFromSuperview()
                let scene = MenuScene(size: self.size)
                let transition = SKTransition.crossFadeWithDuration(1)
                view?.presentScene(scene, transition: transition)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}