//
//  RandomObject.swift
//  MobileApp
//
//  Created by Joshua Warejko on 4/7/20.
//  Copyright © 2020 Rochelle Chan. All rights reserved.
//

import SpriteKit

class RandomObject {
    var scene: PlayGameScene
    var active: Bool = false
    var node: SKShapeNode
    static let radius: CGFloat = 50;
    
    init(scene: PlayGameScene) {
        self.scene = scene
        
        // https://stackoverflow.com/questions/30318002/spawning-a-circle-in-a-random-spot-on-screen
        let viewMidX = scene.view!.bounds.midX
        let viewMidY = scene.view!.bounds.midY

        let currentBall = SKShapeNode(circleOfRadius: 50)
        currentBall.fillColor = SKColor.green
        let xPosition = scene.frame.midX - viewMidX + CGFloat(arc4random_uniform(UInt32(viewMidX*2)))
        let yPosition = scene.frame.midY - viewMidY + CGFloat(arc4random_uniform(UInt32(viewMidY*2)))

        currentBall.position = CGPoint(x: xPosition, y: yPosition)
        currentBall.name = "ball-" + String(Int.random(in: 1..<99999999999))
        self.node = currentBall
        self.active = true
        scene.addChild(self.node)
    }
    
    /**
     * Remove the object from the scene and from the active objects array on the GameScene.
     */
    public func removeObject() {
        self.active = false
        self.node.removeFromParent()
    }
}
