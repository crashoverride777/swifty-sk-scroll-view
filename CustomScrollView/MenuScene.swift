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
        clickLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(clickLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let scene = GameScene(size: size)
        let transition = SKTransition.crossFadeWithDuration(1)
        view?.presentScene(scene, transition: transition)
    }
}
