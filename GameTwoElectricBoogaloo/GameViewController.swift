//
//  GameViewController.swift
//  GameTwoElectricBoogaloo
//
//  Created by RYAN STARK on 10/10/24.
//
var access: GameScene!

import UIKit
import SpriteKit
import GameplayKit
import CoreLocation

class GameViewController: UIViewController {

    //outlets{ ------------------------------

    @IBOutlet weak var cursorBL: UILabel!
    
    @IBOutlet weak var lupBL: UILabel!
    @IBOutlet weak var upBL: UILabel!
    @IBOutlet weak var rupBL: UILabel!
    @IBOutlet weak var leftBL: UILabel!
    @IBOutlet weak var rightBL: UILabel!
    @IBOutlet weak var ldownBL: UILabel!
    @IBOutlet weak var downBL: UILabel!
    @IBOutlet weak var rdownBL: UILabel!
    @IBOutlet weak var heart1: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    @IBOutlet weak var heart3: UIImageView!
    
    //outlets} ------------------------------
    
    
    //variables{ ------------------------------
    
    var dotimer = false
    var verticle = false
    var horizontal = false
    var updiag = false
    var downdiag = false
    var x = 0.0
    var y = 0.0
    
    //variables} ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()

        cursorBL.layer.cornerRadius = 32.5
        cursorBL.layer.masksToBounds = true
//        lupBL.isHidden = true
//        upBL.isHidden = true
//        rupBL.isHidden = true
//        leftBL.isHidden = true
//        rightBL.isHidden = true
//        ldownBL.isHidden = true
//        downBL.isHidden = true
//        rdownBL.isHidden = true

        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                //play thing
                access = scene as? GameScene
                access.gameViewController = self
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
                    UIDevice.current.setValue(value, forKey: "orientation")
        
    }
    
    //movement buttons{ ------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        x = Double(touch.location(in: self.view).x)
        y = Double(touch.location(in: self.view).y)
        
//        let xpart = x-Double(leftBL.center.x+leftBL.frame.width)
//        let ypart = y-Double(leftBL.center.y)
//        let result = sqrt((xpart*xpart)+(ypart*ypart))
//        if result<=105.0{
            cursorBL.center = CGPoint(x: x, y: y)
//        }
//        print(result)
        
        //verticle checks
        if checkBounds(x: x, y: y, lab: upBL){
                access.Player.physicsBody?.velocity = CGVector(dx: (access.Player.physicsBody?.velocity.dx)!, dy: 300)
                verticle = true
        } else if checkBounds(x: x, y: y, lab: downBL){
                access.Player.physicsBody?.velocity = CGVector(dx: (access.Player.physicsBody?.velocity.dx)!, dy: -300)
                verticle = true
        } else if !checkBounds(x: x, y: y, lab: upBL) && verticle{
                access.Player.physicsBody?.velocity = CGVector(dx: (access.Player.physicsBody?.velocity.dx)!, dy: 0)
                verticle = false
        } else if !checkBounds(x: x, y: y, lab: downBL) && verticle{
                access.Player.physicsBody?.velocity = CGVector(dx: (access.Player.physicsBody?.velocity.dx)!, dy: 0)
                verticle = false
        }
        //horizontal checks
        if checkBounds(x: x, y: y, lab: rightBL){
                access.Player.physicsBody?.velocity = CGVector(dx: 300, dy: (access.Player.physicsBody?.velocity.dy)!)
            horizontal = true
        } else if checkBounds(x: x, y: y, lab: leftBL){
                access.Player.physicsBody?.velocity = CGVector(dx: -300, dy: (access.Player.physicsBody?.velocity.dy)!)
            horizontal = true
        } else if !checkBounds(x: x, y: y, lab: rightBL) && horizontal{
                access.Player.physicsBody?.velocity = CGVector(dx: 0, dy: (access.Player.physicsBody?.velocity.dy)!)
            horizontal = false
        } else if !checkBounds(x: x, y: y, lab: leftBL) && horizontal{
                access.Player.physicsBody?.velocity = CGVector(dx: 0, dy: (access.Player.physicsBody?.velocity.dy)!)
            horizontal = false
        }
        //top diagnol
        if checkBounds(x: x, y: y, lab: lupBL){
            access.Player.physicsBody?.velocity = CGVector(dx: -300, dy:300)
            updiag = true
        } else if checkBounds(x: x, y: y, lab: rupBL){
            access.Player.physicsBody?.velocity = CGVector(dx: 300, dy:300)
            updiag = true
        } else if !checkBounds(x: x, y: y, lab: lupBL) && updiag{
            access.Player.physicsBody?.velocity = CGVector(dx: 0, dy:0)
            updiag = false
        } else if !checkBounds(x: x, y: y, lab: rupBL) && updiag{
            access.Player.physicsBody?.velocity = CGVector(dx: 0, dy:0)
            updiag = false
        }
        // down diagnol
        if checkBounds(x: x, y: y, lab: ldownBL){
            access.Player.physicsBody?.velocity = CGVector(dx: -300, dy:-300)
            downdiag = true
        } else if checkBounds(x: x, y: y, lab: rdownBL){
            access.Player.physicsBody?.velocity = CGVector(dx: 300, dy:-300)
            downdiag = true
        } else if !checkBounds(x: x, y: y, lab: ldownBL) && downdiag{
            access.Player.physicsBody?.velocity = CGVector(dx: 0, dy:0)
            downdiag = false
        } else if !checkBounds(x: x, y: y, lab: rdownBL) && downdiag{
            access.Player.physicsBody?.velocity = CGVector(dx: 0, dy:0)
            downdiag = false
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        x = Double(touch.location(in: self.view).x)
        y = Double(touch.location(in: self.view).y)
        
//        let xpart = x-Double(leftBL.center.x+leftBL.frame.width)
//        let ypart = y-Double(leftBL.center.y)
//        let result = sqrt((xpart*xpart)+(ypart*ypart))
//        if result<=120.0{
            cursorBL.center = CGPoint(x: x, y: y)
//        }
//        print(result)
        
        //verticle checks
        if checkBounds(x: x, y: y, lab: upBL){
                access.Player.physicsBody?.velocity = CGVector(dx: (access.Player.physicsBody?.velocity.dx)!, dy: 300)
                verticle = true
        } else if checkBounds(x: x, y: y, lab: downBL){
                access.Player.physicsBody?.velocity = CGVector(dx: (access.Player.physicsBody?.velocity.dx)!, dy: -300)
                verticle = true
        } else if !checkBounds(x: x, y: y, lab: upBL) && verticle{
                access.Player.physicsBody?.velocity = CGVector(dx: (access.Player.physicsBody?.velocity.dx)!, dy: 0)
                verticle = false
        } else if !checkBounds(x: x, y: y, lab: downBL) && verticle{
                access.Player.physicsBody?.velocity = CGVector(dx: (access.Player.physicsBody?.velocity.dx)!, dy: 0)
                verticle = false
        }
        //horizontal checks
        if checkBounds(x: x, y: y, lab: rightBL){
                access.Player.physicsBody?.velocity = CGVector(dx: 300, dy: (access.Player.physicsBody?.velocity.dy)!)
            horizontal = true
        } else if checkBounds(x: x, y: y, lab: leftBL){
                access.Player.physicsBody?.velocity = CGVector(dx: -300, dy: (access.Player.physicsBody?.velocity.dy)!)
            horizontal = true
        } else if !checkBounds(x: x, y: y, lab: rightBL) && horizontal{
                access.Player.physicsBody?.velocity = CGVector(dx: 0, dy: (access.Player.physicsBody?.velocity.dy)!)
            horizontal = false
        } else if !checkBounds(x: x, y: y, lab: leftBL) && horizontal{
                access.Player.physicsBody?.velocity = CGVector(dx: 0, dy: (access.Player.physicsBody?.velocity.dy)!)
            horizontal = false
        }
        //top diagnol
        if checkBounds(x: x, y: y, lab: lupBL){
            access.Player.physicsBody?.velocity = CGVector(dx: -300, dy:300)
            updiag = true
        } else if checkBounds(x: x, y: y, lab: rupBL){
            access.Player.physicsBody?.velocity = CGVector(dx: 300, dy:300)
            updiag = true
        } else if !checkBounds(x: x, y: y, lab: lupBL) && updiag{
            access.Player.physicsBody?.velocity = CGVector(dx: 0, dy:0)
            updiag = false
        } else if !checkBounds(x: x, y: y, lab: rupBL) && updiag{
            access.Player.physicsBody?.velocity = CGVector(dx: 0, dy:0)
            updiag = false
        }
        // down diagnol
        if checkBounds(x: x, y: y, lab: ldownBL){
            access.Player.physicsBody?.velocity = CGVector(dx: -300, dy:-300)
            downdiag = true
        } else if checkBounds(x: x, y: y, lab: rdownBL){
            access.Player.physicsBody?.velocity = CGVector(dx: 300, dy:-300)
            downdiag = true
        } else if !checkBounds(x: x, y: y, lab: ldownBL) && downdiag{
            access.Player.physicsBody?.velocity = CGVector(dx: 0, dy:0)
            downdiag = false
        } else if !checkBounds(x: x, y: y, lab: rdownBL) && downdiag{
            access.Player.physicsBody?.velocity = CGVector(dx: 0, dy:0)
            downdiag = false
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        access.Player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        cursorBL.center = CGPoint(x: leftBL.center.x+leftBL.frame.width, y: leftBL.center.y)
    }

    
    //movement buttons} ------------------------------
    
    //funcs{ ------------------------------
    
    func checkBounds(x: Double, y: Double, lab: UILabel)-> Bool{
        var retu = false
        if x > Double(lab.center.x-lab.frame.width/2) && x < Double(lab.center.x+lab.frame.width/2) && y > Double(lab.center.y-lab.frame.height/2) && y < Double(lab.center.y+lab.frame.height/2) {
            retu = true
        }
        return retu
    }
    
    func loseHealth(h: Int) {
        if h == 2 {
            heart1.image = UIImage(named: "emptyheart")
        } else if h == 1 {
            heart2.image = UIImage(named: "emptyheart")
        } else{
            heart3.image = UIImage(named: "emptyheart")
        }
    }
    //funcs} ------------------------------

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
