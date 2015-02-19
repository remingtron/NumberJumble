//
//  TileSprite.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/13/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import SpriteKit

public class TileSprite: SKSpriteNode {
    
    public class var LastTouchedSpriteColor : UIColor {
        return UIColor.yellowColor()
    }
    
    public class var TouchedSpriteColor : UIColor {
        return UIColor(red: 1, green: 0.816, blue: 0.31, alpha: 1)
    }
    
    public class var UntouchedSpriteColor : UIColor {
        return UIColor.whiteColor()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    public init(value: Int, size: CGFloat) {
        let texture = SKTexture(imageNamed: "Tile")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: size, height: size))

        color = TileSprite.UntouchedSpriteColor
        colorBlendFactor = 1
        
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
    
    public func markTouched() {
        color = TileSprite.TouchedSpriteColor
    }
    
    public func markLastTouched() {
        color = TileSprite.LastTouchedSpriteColor
    }
    
    public func markUntouched() {
        color = TileSprite.UntouchedSpriteColor
    }
}
