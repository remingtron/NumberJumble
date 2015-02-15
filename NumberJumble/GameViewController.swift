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
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = configureView()
        let level = Level(gridSize: 6)
        let scene = createGameScene(skView, level: level)
        
        skView.presentScene(scene)
    }
    
    private func configureView() -> SKView {
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        return skView
    }
    
    private func createGameScene(view: SKView, level: Level) -> GameScene {
        var scene = GameScene(size: view.bounds.size, level: level)
        scene.scaleMode = .AspectFill
        scene.tileTouchedHandler = tileTouched
        return scene
    }
    
    func tileTouched(column: Int, row: Int) {
        println("Tile touched at column: \(column), row: \(row)")
    }
}
