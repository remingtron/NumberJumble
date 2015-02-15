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
    
    private var gridLayer: SKNode!
    private var currentTotalLabel: SKLabelNode!
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    public override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = colorForBackground
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        buildGridLayer()
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
    
    func buildGridLayer() {
        gridLayer = SKNode()
        gridLayer.name = "gridLayer"
        addChild(gridLayer)
        
        for row in 0..<5 {
            for column in 0..<5 {
                let tile = TileSprite(value: Int(arc4random_uniform(9)+1), size: 100)
                tile.position = CGPoint(x: CGFloat(100.0*(CGFloat(row)-2)), y: CGFloat(100.0*(CGFloat(column)-2)))
                gridLayer.addChild(tile)
            }
        }
    }
}
