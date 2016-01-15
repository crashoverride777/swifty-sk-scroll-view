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
    var scrollView: CustomScrollView!
    
    /// Moveable node in the scrollView
    let moveableNode = SKNode()
    
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
        scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * 3) // * 3 makes it 3times as long as screen
        view!.addSubview(scrollView)

        /// ScrollView Sprites for each page in scrollView
        /// Makes positioning much easier.
        let page1ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
        page1ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        moveableNode.addChild(page1ScrollView)
        
        let page2ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
        page2ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - (self.frame.size.height))
        moveableNode.addChild(page2ScrollView)
        
        let page3ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
        page3ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - (self.frame.size.height * 2))
        moveableNode.addChild(page3ScrollView)
        
        /// Test label page 1
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPointMake(0, 0)
        page1ScrollView.addChild(myLabel)
        
        /// Test sprite page 2
        let sprite = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
        sprite.position = CGPointMake(0, 0)
        page2ScrollView.addChild(sprite)
        
        /// Test sprite page 3
        let sprite2 = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: 50, height: 50))
        sprite2.position = CGPointMake(0, 0)
        page3ScrollView.addChild(sprite2)
    }
    
    // MARK: - Horizontal scrolling properties
    func prepareHorizontalScrolling() {
        
        /// Set up scrollView
        scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), scene: self, moveableNode: moveableNode, scrollDirection: .Horizontal)
        scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height) // * 3 makes it three times as wide as screen
        view!.addSubview(scrollView)
        
        /// Set scrollView to first page
        scrollView.setContentOffset(CGPoint(x: 0 + self.frame.size.width * 2, y: 0), animated: true)
        
        /// ScrollView Sprites for each page in scrollView
        /// Makes positioning much easier.
        let page1ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
        page1ScrollView.zPosition = -1
        page1ScrollView.position = CGPointMake(CGRectGetMidX(self.frame) - (self.frame.size.width * 2), CGRectGetMidY(self.frame))
        moveableNode.addChild(page1ScrollView)
        
        let page2ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
        page2ScrollView.zPosition = -1
        page2ScrollView.position = CGPointMake(CGRectGetMidX(self.frame) - (self.frame.size.width), CGRectGetMidY(self.frame))
        moveableNode.addChild(page2ScrollView)
        
        let page3ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
        page3ScrollView.zPosition = -1
        page3ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        moveableNode.addChild(page3ScrollView)
        
        
        /// Test label page 1
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPointMake(0, 0)
        page1ScrollView.addChild(myLabel)
        
        /// Test sprite page 2
        let sprite = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
        sprite.position = CGPointMake(0, 0)
        page2ScrollView.addChild(sprite)
        
        /// Test sprite page 3
        let sprite2 = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: 50, height: 50))
        sprite2.position = CGPointMake(0, 0)
        page3ScrollView.addChild(sprite2)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            
            nodesTouched = nodesAtPoint(location)
            for node in nodesTouched {
                node.touchesBegan(touches, withEvent: event) // touches began in this case
                print("Item in scroll view pressed/moved,ended")
                
                // just do you thing here as usual
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}