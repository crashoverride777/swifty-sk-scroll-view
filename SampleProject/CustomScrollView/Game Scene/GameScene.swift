//
//  GameScene.swift
//  SwiftySKScrollView
//
//  Created by Dominik on 19/03/2016.
//  Copyright © 2016 Dominik. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    private var didTapScreen = false
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.red
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !didTapScreen else { return }
        didTapScreen = true
        
        let scene = SKScene(fileNamed: GameViewController.Scene.menu.rawValue)!
        scene.scaleMode = .aspectFill
        let transition = SKTransition.crossFade(withDuration: 1)
        view?.presentScene(scene, transition: transition)
    }
}
