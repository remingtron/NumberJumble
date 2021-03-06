//
//  GameScene.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/10/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import SpriteKit

public class GameScene: SKScene {
    
    public let colorForBackground = UIColor(red: 0.19, green: 0.58, blue: 0.83, alpha:1.0)
    private let mainGameFont = "GillSans-Bold"
    
    public var gridLayer: GridLayer!
    
    // exposing these as public for integration tests in GameViewControllerSpec
    public var currentTotalLabel: SKLabelNode!
    public var targetTotalLabel: SKLabelNode!
    public var scoreLabel: SKLabelNode!
    public var timerLabel: SKLabelNode!
    
    public var tileTouchedHandler: ((column: Int, row: Int) -> ())?
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    public init(size: CGSize, level: Level) {
        super.init(size: size)
        
        backgroundColor = colorForBackground
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        buildGridLayer(level)
        buildCurrentTotalLabel()
        buildTargetTotalLabel(level)
        buildScoreLabel(level)
        buildTimerLabel(level)
    }
    
    func buildTimerLabel(level: Level) {
        timerLabel = SKLabelNode(text: "")
        timerLabel.name = "timer"
        timerLabel.fontName = mainGameFont
        timerLabel.fontSize = 120
        timerLabel.position = CGPoint(x: 170, y: -430)
        addChild(timerLabel)
        updateTimer(level.getTimeRemaining())
    }
    
    func buildCurrentTotalLabel() {
        currentTotalLabel = SKLabelNode(text: "0")
        currentTotalLabel.name = "currentTotal"
        currentTotalLabel.fontName = mainGameFont
        currentTotalLabel.fontSize = 120
        currentTotalLabel.position = CGPoint(x: 250, y: 375)
        addChild(currentTotalLabel)
    }
    
    func buildTargetTotalLabel(level: Level) {
        targetTotalLabel = SKLabelNode()
        updateTarget(level.targetValue)
        targetTotalLabel.name = "targetTotal"
        targetTotalLabel.fontName = mainGameFont
        targetTotalLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        targetTotalLabel.fontSize = 70
        targetTotalLabel.position = CGPoint(x: -300, y: 340)
        addChild(targetTotalLabel)
    }
    
    func buildScoreLabel(level: Level) {
        scoreLabel = SKLabelNode()
        updateScore(level.getScore())
        scoreLabel.name = "score"
        scoreLabel.fontName = mainGameFont
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        scoreLabel.fontSize = 70
        scoreLabel.position = CGPoint(x: -300, y: 420)
        addChild(scoreLabel)
    }
    
    func buildGridLayer(level: Level) {
        gridLayer = GridLayer(tiles: level.tiles)
        gridLayer.name = "gridLayer"
        addChild(gridLayer)
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        touchHandler(touch.locationInNode(gridLayer))
    }
    
    public func touchHandler(location: CGPoint) {
        let (tileFound, column, row) = gridLayer.tileAtPoint(location)
        if tileFound {
            tileTouchedHandler!(column: column, row: row)
        }
    }
    
    public func updateCurrentTotal(total: Int) {
        currentTotalLabel.text = String(total)
    }
    
    public func markSpritesTouched(tiles: Array<Tile>) {
        for tile in tiles {
            gridLayer.tileSprites[tile.column, tile.row]!.markTouched()
        }
        if let lastTile = tiles.last {
            gridLayer.tileSprites[lastTile.column, lastTile.row]!.markLastTouched()
        }
    }
    
    public func updateScore(score: Int) {
        scoreLabel.text = "Score: \(score)"
    }
    
    public func updateTarget(target: Int) {
        targetTotalLabel.text = "Target: \(target)"
    }
    
    public func updateTimer(timer: Int) {
        timerLabel.text = SecondsToTimeFormatter.convert(timer, showZeroMinutes: false)
    }
    
    public func clearSelectedTiles() {
        let tileSprites = gridLayer.tileSprites
        for column in 0..<tileSprites.columns {
            for row in 0..<tileSprites.rows {
                tileSprites[column, row]!.markUntouched()
            }
        }
    }
    
    public func replaceSelectedTiles(selectedTiles: Array<Tile>, newGrid: Array2D<Tile>) {
        for tile in selectedTiles {
            gridLayer.replaceSprite(tile.column, row: tile.row, newValue: newGrid[tile.column, tile.row]!.value)
        }
    }
    
}
