//
//  PlayGameScene.swift
//  MobileApp
//
//  Created by Joshua Warejko on 4/7/20.
//  Copyright © 2020 Rochelle Chan. All rights reserved.
//

import Foundation
import SpriteKit

class PlayGameScene: SKScene {
    var activeObjects: [RandomObject] = []
    
    override init(size: CGSize) {
      super.init(size: size)
      
      // Set background color to white.
      backgroundColor = SKColor.white
      
      // Place the label on the screen after setting a few properties.
      let label = SKLabelNode(fontNamed: "Chalkduster")
      label.text = "Hello Game"
      label.fontSize = 40
      label.fontColor = SKColor.black
      label.position = CGPoint(x: size.width/2, y: size.height/2)
      addChild(label)
     }
    
    // Have to add this for some reason.
    required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        // Add tap recognizer so the label moves to where the user tapped.
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(recognizer)
        
        // Add a few objects to the screen
        let obj1 = RandomObject(scene: self)
        let obj2 = RandomObject(scene: self)
        let obj3 = RandomObject(scene: self)
        self.activeObjects.append(obj1)
        self.activeObjects.append(obj2)
        self.activeObjects.append(obj3)
    }
    
    /**
     *  Runs when the screen is tapped.
     */
    @objc func tap(recognizer: UIGestureRecognizer) {
        let viewLocation = recognizer.location(in: view)
        let sceneLocation = convertPoint(fromView: viewLocation)
        let tappedObj = didTapObject(touchLocation: sceneLocation)
        // Check if we tapped an object and remove it if so.
        if tappedObj != nil {
            tappedObj?.removeObject()
            for (index, object) in self.activeObjects.enumerated() {
                if(object.node.name == tappedObj?.node.name) {
                    self.activeObjects.remove(at: index)
                    checkEndOfGame()
                    break
                }
            }
        }
    }
    
    /**
     *  Check if an object was tapped and return it.
     */
    private func didTapObject(touchLocation: CGPoint) -> RandomObject! {
        print(touchLocation)
        for randomObject in activeObjects {
            let currentObjPos = randomObject.node.position
            let xUpperBound = currentObjPos.x + RandomObject.radius
            let xLowerBound = currentObjPos.x - RandomObject.radius
            let yUpperBound = currentObjPos.y + RandomObject.radius
            let yLowerBound = currentObjPos.y - RandomObject.radius
            print(xLowerBound, xUpperBound, yLowerBound, yUpperBound)
            if touchLocation.x > xLowerBound && touchLocation.x < xUpperBound && touchLocation.y > yLowerBound && touchLocation.y < yUpperBound {
                return randomObject
            }
        }
        return nil
    }
    
    /**
     *  Checks if the game is won (no more active objects) and changes scene to game over scene.
     */
    private func checkEndOfGame() {
        if self.activeObjects.count == 0 {
            run(SKAction.sequence([
                SKAction.wait(forDuration: 0.3),
              SKAction.run() { [weak self] in
                // 5
                guard let `self` = self else { return }
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let scene = GameOverScene(size: self.size, won: true)
                self.view?.presentScene(scene, transition:reveal)
              }
            ]))
        }
    }
}
