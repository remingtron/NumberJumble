//
//  GameScene.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/10/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let color = UIColor(red: 0.19, green: 0.58, blue: 0.83, alpha:1.0)
        let background = SKSpriteNode(color: color, size: size)
        addChild(background)
    }
}
