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
            
            let underTest = Tile(column: 1, row: 2, value: 3)
            
            it("has a value") {
                expect(underTest.value).to(equal(3))
            }
            
            it("has a column") {
                expect(underTest.column).to(equal(1))
            }
            
            it("has a row") {
                expect(underTest.row).to(equal(2))
            }
            
        }
    }
    
}
