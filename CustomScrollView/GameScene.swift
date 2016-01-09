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
        
        /// set up scrollView
        scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), scene: self, moveableNode: moveableNode)
        scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * 2) // * 2 makes it twice as long as screen
        view.addSubview(scrollView)
        
        /// sprite
        let sprite = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
        sprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - self.frame.size.height)
        moveableNode.addChild(sprite)
        
        /// label
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        moveableNode.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
