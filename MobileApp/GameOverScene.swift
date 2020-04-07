//
//  GameOverScene.swift
//  MobileApp
//
//  Created by Joshua Warejko on 4/7/20.
//  Copyright © 2020 Rochelle Chan. All rights reserved.
//

import Foundation

import SpriteKit

class GameOverScene: SKScene {
  init(size: CGSize, won:Bool) {
    super.init(size: size)
    
    // Set background color to white.
    backgroundColor = SKColor.white
    
    // Set messsage based on winning or losing.
    let message = won ? "You Won!" : "You Lose :["
    
    // Place the label on the screen after setting a few properties.
    let label = SKLabelNode(fontNamed: "Chalkduster")
    label.text = message
    label.fontSize = 40
    label.fontColor = SKColor.black
    label.position = CGPoint(x: size.width/2, y: size.height/2)
    addChild(label)
    
    // Set up a squence of actions:
    // Wait for 3 seconds, then run some code.
    run(SKAction.sequence([
      SKAction.wait(forDuration: 3.0),
      SKAction.run() { [weak self] in
        // 5
        guard let `self` = self else { return }
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let scene = GameScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
      }
    ]))
   }
  
  // Have to add this for some reason.
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

