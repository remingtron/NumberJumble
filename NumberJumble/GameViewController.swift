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
    
    // probably shouldn't be exposing these as public, but rather injecting them, but not sure how with the way this is initialized
    public var level: Level!
    public var scene: GameScene!
    public var timer: NSTimer!
    public var gameLength = 0
    public var useChainLengthScoring = false
    
    public override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    public override func shouldAutorotate() -> Bool {
        return true
    }
    
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let foo = presentedViewController
        resetGame()
    }
    
    private func resetGame() {
        let skView = configureView()
        setupGame(skView)
        
        skView.presentScene(scene)
        startGame()
    }
    
    // TODO: had to peel this out separately for testing.  should this really happen in an init anyway?
    public func setupGame(view: SKView) {
        self.level = Level(gridSize: 6, length: gameLength, useChainLengthScoring: useChainLengthScoring)
        self.scene = createGameScene(view, level: level)
    }
    
    public func startGame() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("timerFire"), userInfo: nil, repeats: true)
    }
    
    // must be public for timer to find it (and to test it)
    public func timerFire() {
        level.timerFire()
        scene.updateTimer(level.getTimeRemaining())
        
        if (level.getTimeRemaining() == 0) {
            timer.invalidate()
            showEndScreen()
        }
    }
    
    public func showEndScreen() {
        let endController = storyboard!.instantiateViewControllerWithIdentifier("endController") as! EndViewController
        endController.setFinalScore(level.getScore())
        presentViewController(endController, animated: true, completion: nil)
    }
    
    public func playAgainTouchHandler() {
        self.resetGame()
    }
    
    private func configureView() -> SKView {
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        return skView
    }
    
    private func createGameScene(view: SKView, level: Level) -> GameScene {
        let scene = GameScene(size: view.bounds.size, level: level)
        scene.scaleMode = .AspectFill
        scene.tileTouchedHandler = tileTouched
        return scene
    }
    
    public func tileTouched(column: Int, row: Int) {
        let result = level.tryTouchTileAt(column, row: row)
        if result.targetHit {
            scene.replaceSelectedTiles(level.getLastTargetTiles(), newGrid: level.tiles)
            scene.updateScore(level.getScore())
            scene.updateTarget(level.targetValue)
        }
        if result.touchSuccess {
            scene.updateCurrentTotal(level.getCurrentTotal())
            scene.markSpritesTouched(level.getCurrentlySelectedTiles())
        }
    }
    
    @IBAction public func clearButtonClicked(sender: UIButton) {
        level.resetSelections()
        scene.clearSelectedTiles()
        scene.updateCurrentTotal(level.getCurrentTotal())
    }
    
}
