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
    
    private var gridLayer: GridLayer!
    private var currentTotalLabel: SKLabelNode!
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    public init(size: CGSize, level: Level) {
        super.init(size: size)
        
        backgroundColor = colorForBackground
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        buildGridLayer(level)
        buildCurrentTotalLabel()
    }
    
    func buildCurrentTotalLabel() {
        currentTotalLabel = SKLabelNode(text: "0")
        currentTotalLabel.name = "currentTotal"
        currentTotalLabel.fontName = "GillSans-Bold"
        currentTotalLabel.fontSize = 100
        currentTotalLabel.position = CGPoint(x: 0, y: 400)
        addChild(currentTotalLabel)
    }
    
    func buildGridLayer(level: Level) {
        gridLayer = GridLayer(tiles: level.tiles)
        gridLayer.name = "gridLayer"
        addChild(gridLayer)
    }
}
