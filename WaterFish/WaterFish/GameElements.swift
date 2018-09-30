//
//  GameElements.swift
//  WaterFish
//
//  Created by Apeksha Sahu on 7/17/18.
//  Copyright © 2018 Apeksha Sahu. All rights reserved.
//

import SpriteKit


struct CollisionBitMask {
    
    static let Player:UInt32 = 0x00
    static let Obstacle:UInt32 = 0x01
}
enum ObstacleType:Int {
    case Small = 0
    case Medium = 1
    case Large = 2
}
enum RowType:Int {
case oneS = 0
case oneM = 1
case oneL = 2
case twoS = 3
case twoM = 4
case threeS = 5
}

extension GameScene{
    
    func addPlayer() {
        
        player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 20, height: 20))
        player.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 50)
        player.physicsBody?.isDynamic = false
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = CollisionBitMask.Player
        player.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
        player2 = SKSpriteNode(color: UIColor.red, size: CGSize(width: 20, height: 20))
        player2.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 50)
        player2.physicsBody?.isDynamic = false
        player2.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player2.physicsBody?.categoryBitMask = CollisionBitMask.Player
        player2.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
        addChild(player)
        addChild(player2)
        
        initialPlayerPosition = player.position
        
    }
    
    func addObstacle(type:ObstacleType) -> SKSpriteNode {
        
        let obstacle = SKSpriteNode(color: UIColor.white, size: CGSize(width: 0, height: 10))
        obstacle.name = "OBSTACLE"
        obstacle.physicsBody?.isDynamic = true
        switch type {
            
        case .Small:
            obstacle.size.width = self.size.width * 0.2
            break
        case .Medium:
              obstacle.size.width = self.size.width * 0.35
            break
        case .Large:
              obstacle.size.width = self.size.width * 0.75
            break
        }
        obstacle.position = CGPoint(x: self.frame.minX, y: self.size.height + obstacle.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        return obstacle
        
        }
    
    
    func addMovement (obstacle:SKSpriteNode) {
   var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: obstacle.position.x, y: self.frame.minY + obstacle.size.height), duration: TimeInterval(3)))
        actionArray.append(SKAction.removeFromParent())
        obstacle.run(SKAction.sequence(actionArray))
        
        
        }
    
    func addRow(type:RowType) {
        
        
        switch type {
            
        case .oneS:
            let obst = addObstacle(type: .Small)
            obst.position = CGPoint(x: self.frame.minX + 200, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
           break
        case .oneM:
            let obst = addObstacle(type: .Medium)
            obst.position = CGPoint(x: self.frame.minX + 200, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            break
        case .oneL:
            let obst = addObstacle(type: .Large)
            obst.position = CGPoint(x: self.frame.minX + 200, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            break
        case .twoS:
            let obst = addObstacle(type: .Small)
            obst.position = CGPoint(x: self.frame.minX + 100, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            let obst2 = addObstacle(type: .Small)
            obst2.position = CGPoint(x: self.frame.midX + obst2.size.width + 50, y: obst.position.y)
            addMovement(obstacle: obst2)
            addChild(obst2)
            break
        case .twoM:
            let obst = addObstacle(type: .Medium)
            obst.position = CGPoint(x: self.frame.minX + 100, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            let obst2 = addObstacle(type: .Medium)
            obst2.position = CGPoint(x: self.frame.midX + obst2.size.width/2 + 50, y: obst2.position.y)
            addMovement(obstacle: obst2)
            addChild(obst2)
            break
        case .threeS:
            let obst1 = addObstacle(type: .Small)
            obst1.position = CGPoint(x: self.frame.minX + 75, y: obst1.position.y)
            addMovement(obstacle: obst1)
            addChild(obst1)
            let obst2 = addObstacle(type: .Small)
            obst2.position = CGPoint(x: self.frame.midX , y: obst1.position.y)
            addMovement(obstacle: obst2)
            addChild(obst2)
            let obst3 = addObstacle(type: .Small)
            obst3.position = CGPoint(x: self.frame.maxX - 75 , y: obst1.position.y)
            addMovement(obstacle: obst3)
            addChild(obst3)
            
            break
            
        }
    }
    
    
    
    
    
    }

