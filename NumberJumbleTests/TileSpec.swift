//
//  TileSpec.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/11/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import Quick
import Nimble
import NumberJumble
import SpriteKit

class TileSpec: QuickSpec {
    
    override func spec() {
        describe("a tile") {
            
            let underTest = Tile(value: 3, size: 100)
            
            it("has a value") {
                expect(underTest.value).to(equal(3))
            }
            
            context("sprite") {
                
                let sprite = underTest.sprite
            
                it("has the tile image") {
                    expect(sprite.texture?.description).to(contain("'Tile'"))
                }
                
                it("has the specified size") {
                    expect(sprite.size).to(equal(CGSize(width: 100, height: 100)))
                }
                
                context("value label") {
                
                    let valueLabel = underTest.sprite.childNodeWithName("valueLabel") as? SKLabelNode
                    
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
    
}
