//
//  MenuScene.swift
//  CustomScrollView
//
//  Created by Dominik on 19/03/2016.
//  Copyright © 2016 Dominik. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.red
        
        let clickLabel = SKLabelNode(fontNamed: "HelveticalNeue")
        clickLabel.horizontalAlignmentMode = .center
        clickLabel.verticalAlignmentMode = .center
        clickLabel.text = "Tap"
        clickLabel.fontSize = 32
        clickLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(clickLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = GameScene(size: size)
        scene.scaleMode = .aspectFill
        let transition = SKTransition.crossFade(withDuration: 1)
        view?.presentScene(scene, transition: transition)
    }
}
