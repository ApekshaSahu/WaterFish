//
//  GameScene.swift
//  WaterFish
//
//  Created by Apeksha Sahu on 7/17/18.
//  Copyright © 2018 Apeksha Sahu. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
   
    var player:SKSpriteNode!
    var player2:SKSpriteNode!
    var initialPlayerPosition:CGPoint!
   
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            
            
            let maximumPossibleForce = touch.maximumPossibleForce
            let force = touch.force
            let normalizedforce = force/maximumPossibleForce
            
            player.position.x = ((self.size.width / 2) - normalizedforce * (self.size.width / 2) - 25)
            player2.position.x = ((self.size.width / 2) - normalizedforce * (self.size.width / 2) - 25)
        }
    }
    
    
    
    override func didMove(to view: SKView) {
        
    
       self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        addPlayer()
        addRow(type: RowType.twoS)
    }
    
    func addRandomRow() {
        
        let randomNumber = Int(arc4random_uniform(6))
        
        switch randomNumber {
        case 0:
            addRow(type: RowType(rawValue: 0)!)
            break
        case 1:
            addRow(type: RowType(rawValue: 1)!)
            break
        case 2:
            addRow(type: RowType(rawValue: 2)!)
            break
        case 3:
            addRow(type: RowType(rawValue: 3)!)
            break
        case 4:
            addRow(type: RowType(rawValue: 4)!)
            break
        case 5:
            addRow(type: RowType(rawValue: 5)!)
            break
        default:
            break
        }
    }
    
    var lastUpdateTimeInterval = TimeInterval()
    var lastYieldTimeInterval = TimeInterval()
    
    func updateWithTimeSinceLastUpdate(timeSinceLastUpdate: CFTimeInterval){
        lastYieldTimeInterval +=  timeSinceLastUpdate
        if lastYieldTimeInterval > 0.6 {
            lastYieldTimeInterval = 0
            addRandomRow()
        }
    }
        
    
    override func update(_ currentTime: TimeInterval) {
     var timeSinceLastUpdate = currentTime - lastYieldTimeInterval
        lastUpdateTimeInterval = currentTime
        if timeSinceLastUpdate > 1 {
            
            timeSinceLastUpdate = 1/60
            lastUpdateTimeInterval = currentTime
        }
    
updateWithTimeSinceLastUpdate(timeSinceLastUpdate: timeSinceLastUpdate)
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "PLAYER" {
            print("Game Over")
            showGameOver()
        }
    }
    
    func showGameOver(){
        
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameScene = GameOverScene(size: self.size)
        self.view?.presentScene(gameScene, transition: transition)
    }
    
    
    
}
