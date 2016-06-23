//
//  MenuScene.swift
//  CustomScrollView
//
//  Created by Dominik on 19/03/2016.
//  Copyright © 2016 Dominik. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.redColor()
        
        let clickLabel = SKLabelNode(fontNamed: "HelveticalNeue")
        clickLabel.horizontalAlignmentMode = .Center
        clickLabel.verticalAlignmentMode = .Center
        clickLabel.text = "Tap"
        clickLabel.fontSize = 32
        clickLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        addChild(clickLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let scene = GameScene(size: self.size)
        let transition = SKTransition.crossFadeWithDuration(1)
        view?.presentScene(scene, transition: transition)
    }
}
