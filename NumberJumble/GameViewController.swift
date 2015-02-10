//
//  GameViewController.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/10/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = configureView()
        let scene = createGameScene(skView)
        
        skView.presentScene(scene)
    }
    
    func configureView() -> SKView {
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        return skView
    }
    
    func createGameScene(view: SKView) -> GameScene {
        var scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .AspectFill
        return scene
    }
}
