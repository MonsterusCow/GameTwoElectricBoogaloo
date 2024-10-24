//
//  GameScene.swift
//  GameTwoElectricBoogaloo
//
//  Created by RYAN STARK on 10/10/24.
//

class Enemies{
    var health = 1
    var size = 10
    
    init(health: Int = 1, size: Int = 10) {
        self.health = health
        self.size = size
    }
}
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
        let straightenFilter = CIFilter.straighten()
        Enemy.texture.
        self.camera = cam
        physicsWorld.contactDelegate = self
        print("hi")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Player" || contact.bodyB.node?.name == "Player" {
            pHealth -= 1
            gameViewController.loseHealth(h: pHealth)
            Enemy.removeFromParent()
        }
    }
    
    func faceEtoP() {
        let angle = atan2(Player.position.y - Enemy.position.y , Player.position.x - Enemy.position.x)
        Enemy.zRotation = angle - CGFloat(Double.pi/2)
    }
//    enemy: Enemies
    func moveEtoP(){
        Enemy.position = CGPoint(x:Enemy.position.x + cos(Enemy.zRotation) * 1,y:Enemy.position.y + sin(Enemy.zRotation) * 1)
    }
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        cam.position = Player.position
//        faceEtoP()
        moveEtoP()


    }
}
