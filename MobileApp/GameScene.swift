//
//  GameScene.swift
//  MobileApp
//
//  Created by Rochelle Chan on 4/1/20.
//  Copyright © 2020 Rochelle Chan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var gameLogo: SKLabelNode!
    
    // May not use SKShapeNode because of rendering here for now but will change
    var playButton: SKShapeNode!
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        initalizeMenu()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    private func initalizeMenu() {
        //Create game title
        gameLogo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 200)
        gameLogo.fontSize = 60
        gameLogo.text = "Where's Essentials"
        gameLogo.fontColor = SKColor.white
        self.addChild(gameLogo)
        
         //Create play button
        playButton = SKShapeNode()
        playButton.name = "play_button"
        playButton.zPosition = 1
        playButton.position = CGPoint(x: 0, y: (frame.size.height / -2) + 200)
        playButton.fillColor = SKColor.cyan
        let topCorner = CGPoint(x: -50, y: 50)
        let bottomCorner = CGPoint(x: -50, y: -50)
        let middle = CGPoint(x: 50, y: 0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        playButton.path = path
        self.addChild(playButton)
    }
}
