//
//  GameViewControllerSpec.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/15/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import Nimble
import Quick
import NumberJumble
import SpriteKit

class GameViewControllerSpec: QuickSpec {
    
    override func spec() {
        describe("game view controller") {
            
            it("updates the current total text when a tile is touched") {
                let underTest = GameViewController()
                underTest.initialize(SKView())
                underTest.tileTouched(2, row: 3)
                
                let valueOfTouchedTile = underTest.level.tiles[2, 3]!.value
                expect(underTest.scene.getCurrentTotal()).to(equal(String(valueOfTouchedTile)))
            }
            
        }
    }
    
}