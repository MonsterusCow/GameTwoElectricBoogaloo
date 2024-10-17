//
//  GameScene.swift
//  GameTwoElectricBoogaloo
//
//  Created by RYAN STARK on 10/10/24.
//

import SpriteKit
import GameplayKit

let cam = SKCameraNode()
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameViewController: GameViewController!
    
    var Player: SKSpriteNode!
    var pHealth = 3
    var Enemy: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        Player = self.childNode(withName: "Player") as? SKSpriteNode
        Enemy = self.childNode(withName: "Spooky") as? SKSpriteNode
        self.camera = cam
        physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Player" || contact.bodyB.node?.name == "Player" {
            pHealth -= 1
            gameViewController.loseHealth(h: pHealth)
            Enemy.removeFromParent()
        }
    }
    
    func moveDude(thing: String){
        if thing == "up"{
            if Int((Player.physicsBody?.velocity.dy)!) < 300 {
                Player.physicsBody?.velocity = CGVector(dx: 0, dy: (Player.physicsBody?.velocity.dy)!+10)
            }
        } else if thing == "down"{
            Player.physicsBody?.velocity = CGVector(dx: 0, dy: -50)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        cam.position = Player.position
    }
}
