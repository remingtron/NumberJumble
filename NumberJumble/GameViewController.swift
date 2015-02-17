//
//  GameViewController.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/10/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import UIKit
import SpriteKit

public class GameViewController: UIViewController {
    
    public var level: Level!
    public var scene: GameScene!
    
    public override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    public override func shouldAutorotate() -> Bool {
        return true
    }
    
    public override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        let skView = configureView()
        initialize(skView)
        
        skView.presentScene(scene)
    }
    
    // TODO: had to peel this out separately for testing.  should this really happen in an init anyway?
    public func initialize(view: SKView) {
        self.level = Level(gridSize: 6)
        self.scene = createGameScene(view, level: level)
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
    
    public func tileTouched(column: Int, row: Int) {
        let touchSuccess = level.tryTouchTileAt(column, row: row)
        if touchSuccess {
            scene.updateCurrentTotal(level.currentTotal)
            scene.markSpriteTouched(column, row: row)
        }
    }
}
