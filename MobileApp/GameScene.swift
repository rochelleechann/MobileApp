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
    
    let label = SKLabelNode(text: "Where's Supplies!")
    var playButton: SKShapeNode!
    
    var activeObjects: [RandomObject] = []
    
    override func didMove(to view: SKView) {
        initializeIntro()
    }
    
    private func initializeIntro() {
        // Set the background color of the view
        backgroundColor = SKColor.white
        
        // Add a start label to the screen, directly in the center.
        label.position = CGPoint(x: frame.size.width / 2, y: (frame.size.height / 2) + 200)
        label.fontSize = 45
        label.fontColor = SKColor.black
        label.fontName = "Avenir"
        self.addChild(label)
        
        // Create play button
        playButton = SKShapeNode()
        playButton.name = "play_button"
        playButton.zPosition = 1
        playButton.position = CGPoint(x: frame.size.width / 2, y: 200)
        playButton.fillColor = SKColor.cyan
        // Create the triangle paths.
        let topCorner = CGPoint(x: -50, y: 50)
        let bottomCorner = CGPoint(x: -50, y: -50)
        let middle = CGPoint(x: 50, y: 0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        // Set the shape of the node.
        playButton.path = path
        self.addChild(playButton)
    }
    
    // Called by game engine every time the user touches the screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "play_button" {
                    startGame()
                }
            }
        }
    }
    
    // Function to start the game.
    private func startGame() {
        print("start game")
        // Move game logo off the screen and then hide it.
        label.run(SKAction.move(by: CGVector(dx: -50, dy: 600), duration: 0.5)) {
            self.label.isHidden = true
        }
        // Scale the play button to 0 and then hide it.
        playButton.run(SKAction.scale(to: 0, duration: 0.3)) {
            self.playButton.isHidden = true
        }
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: 0.3),
          SKAction.run() { [weak self] in
            // 5
            guard let `self` = self else { return }
            let reveal = SKTransition.crossFade(withDuration: 0.5)
            let gameOverScene = PlayGameScene(size: self.size)
            self.view?.presentScene(gameOverScene, transition: reveal)
          }
        ]))
    }


//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
}
