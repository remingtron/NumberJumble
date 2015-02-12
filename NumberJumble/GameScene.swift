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
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    public override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = colorForBackground
        
//        let tile = SKSpriteNode(imageNamed: "Tile")
//        tile.position = CGPoint(x: 300, y: 200)
//        tile.anchorPoint = CGPoint(x: 0.5, y: 0.25)
//        tile.size = CGSize(width: 100, height: 100)
//        
//        // on click, colorize the sprite?
//        tile.color = UIColor.brownColor()
//        tile.colorBlendFactor = 0.5
//        
//        let text = SKLabelNode()
//        text.fontColor = UIColor.blackColor()
//        text.fontSize = 200
//        text.fontName = "GillSans-Bold"
//        tile.addChild(text)
//        
//        addChild(tile)
    }
}
