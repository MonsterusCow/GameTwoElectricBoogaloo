//
//  GameScene.swift
//  GameTwoElectricBoogaloo
//
//  Created by RYAN STARK on 10/10/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var Player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        Player = self.childNode(withName: "Player") as! SKSpriteNode
    }
    
    func moveDude(thing: String){
        if thing == "up"{
            if Int((Player.physicsBody?.velocity.dy)!) < 50 {
                Player.physicsBody?.velocity = CGVector(dx: 0, dy: (Player.physicsBody?.velocity.dy)!+1)
            }
        } else if thing == "down"{
            Player.physicsBody?.velocity = CGVector(dx: 0, dy: -50)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
