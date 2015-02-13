//
//  Tile.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/11/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import SpriteKit

public class Tile {
    
    public let value: Int
    public let sprite: SKSpriteNode
    
    public init(value: Int) {
        self.value = value
        self.sprite = SKSpriteNode(imageNamed: "Tile")
        
        let valueLabel = SKLabelNode(text: String(value))
        valueLabel.name = "valueLabel"
        valueLabel.fontName = "GillSans-Bold"
        valueLabel.fontColor = UIColor.blackColor()
        valueLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        sprite.addChild(valueLabel)
    }
}
