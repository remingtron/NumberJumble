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
            
            let underTest = Tile(value: 3)
            
            it("has a value") {
                expect(underTest.value).to(equal(3))
            }
            
            context("sprite") {
            
                it("has the tile image") {
                    expect(underTest.sprite.texture?.description).to(contain("'Tile'"))
                }
                
                it("has the correct size") {
                    expect(underTest.sprite.size).to(equal(CGSize(width: 125, height: 125)))
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
                }
            }
        }
    }
    
}
