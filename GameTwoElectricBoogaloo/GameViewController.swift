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

class GameViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                //play thing
                access = scene as? GameScene
                
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

    @IBAction func downpress(_ sender: Any) {
        var timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            print("Timer fired!")
        }
    }
    
    @IBAction func stoppress(_ sender: Any) {
        timer.invalidate()
    }
    

    

    
    
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
