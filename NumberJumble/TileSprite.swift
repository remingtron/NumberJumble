//
//  TileSprite.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/13/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import SpriteKit

public class TileSprite: SKSpriteNode {
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    public init(value: Int, size: CGFloat) {
        let texture = SKTexture(imageNamed: "Tile")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: size, height: size))
        addChild(createValueLabel(value))
    }
    
    func createValueLabel(value: Int) -> SKLabelNode {
        let valueLabel = SKLabelNode(text: String(value))
        valueLabel.name = "valueLabel"
        valueLabel.fontName = "GillSans-Bold"
        valueLabel.fontColor = UIColor.blackColor()
        valueLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        valueLabel.fontSize = size.height*0.75
        return valueLabel
    }
}
