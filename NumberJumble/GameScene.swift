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
    
    public var gridLayer: GridLayer!
    
    // exposing these as public for integration tests in GameViewControllerSpec
    public var currentTotalLabel: SKLabelNode!
    public var targetTotalLabel: SKLabelNode!
    public var scoreLabel: SKLabelNode!
    
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
    }
    
    func buildCurrentTotalLabel() {
        currentTotalLabel = SKLabelNode(text: "0")
        currentTotalLabel.name = "currentTotal"
        currentTotalLabel.fontName = "GillSans-Bold"
        currentTotalLabel.fontSize = 100
        currentTotalLabel.position = CGPoint(x: 0, y: 375)
        addChild(currentTotalLabel)
    }
    
    func buildTargetTotalLabel(level: Level) {
        targetTotalLabel = SKLabelNode(text: "Target: \(String(level.targetValue))")
        targetTotalLabel.name = "targetTotal"
        targetTotalLabel.fontName = "GillSans-Bold"
        targetTotalLabel.fontSize = 80
        targetTotalLabel.position = CGPoint(x: 0, y: -390)
        addChild(targetTotalLabel)
    }
    
    func buildScoreLabel(level: Level) {
        scoreLabel = SKLabelNode(text: "Score: \(String(level.getScore()))")
        scoreLabel.name = "score"
        scoreLabel.fontName = "GillSans-Bold"
        scoreLabel.fontSize = 80
        scoreLabel.position = CGPoint(x: 0, y: -475)
        addChild(scoreLabel)
    }
    
    func buildGridLayer(level: Level) {
        gridLayer = GridLayer(tiles: level.tiles)
        gridLayer.name = "gridLayer"
        addChild(gridLayer)
    }
    
    public override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
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
    
    public func clearSelectedTiles() {
        let tileSprites = gridLayer.tileSprites
        for column in 0..<tileSprites.columns {
            for row in 0..<tileSprites.rows {
                tileSprites[column, row]!.markUntouched()
            }
        }
    }
    
}
