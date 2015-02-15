//
//  TileSpriteSpec.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/13/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import Nimble
import Quick
import NumberJumble
import SpriteKit

class TileSpriteSpec: QuickSpec {
    override func spec() {
        describe("tile sprite") {
            
            let sprite = TileSprite(value: 3, size: 100)
            
            it("has the tile image") {
                expect(sprite.texture?.description).to(contain("'Tile'"))
            }
            
            it("has the specified size") {
                expect(sprite.size).to(equal(CGSize(width: 100, height: 100)))
            }
            
            it("has an initial color of white") {
                expect(sprite.color).to(beSameUIColor(UIColor.whiteColor()))
            }
            
            it("has a color blend factor of 1") {
                expect(sprite.colorBlendFactor).to(equal(1))
            }
            
            //UIColor(red: 1, green: 0.81, blue: 0.31, alpha: 1)
            
            context("value label") {
                
                let valueLabel = sprite.childNodeWithName("valueLabel") as? SKLabelNode
                
                it("has text equaling the value of the tile") {
                    expect(valueLabel!.text).to(equal("3"))
                }
                
                it("has the correct font") {
                    expect(valueLabel!.fontName).to(equal("GillSans-Bold"))
                }
                
                it("has the correct font color") {
                    expect(valueLabel!.fontColor).to(beSameUIColor(UIColor.blackColor()))
                }
                
                it("has vertically centered text") {
                    expect(valueLabel!.verticalAlignmentMode.rawValue).to(equal(SKLabelVerticalAlignmentMode.Center.rawValue))
                }
                
                it("has font size that's a percentage of the surrounding sprite") {
                    expect(valueLabel!.fontSize).to(equal(sprite.size.height*0.75))
                }
                
            }
            
        }
        
    }
}
