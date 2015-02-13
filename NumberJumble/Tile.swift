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
    
    public init(value: Int, size: Int) {
        self.value = value
        self.sprite = SKSpriteNode(imageNamed: "Tile")
        sprite.size = CGSize(width: size, height: size)
        
        sprite.addChild(createValueLabel(value))
    }
    
    func createValueLabel(value: Int) -> SKLabelNode {
        let valueLabel = SKLabelNode(text: String(value))
        valueLabel.name = "valueLabel"
        valueLabel.fontName = "GillSans-Bold"
        valueLabel.fontColor = UIColor.blackColor()
        valueLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        valueLabel.fontSize = sprite.size.height*0.75
        return valueLabel
    }
}
