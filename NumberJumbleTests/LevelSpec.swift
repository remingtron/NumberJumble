//
//  LevelSpec.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/11/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import Quick
import Nimble
import NumberJumble

class LevelSpec: QuickSpec {
    
    override func spec() {
        describe("level") {

            var underTest: Level?
            
            beforeEach {
                underTest = Level(gridSize: 5)
            }
            
            it("has a grid of tiles") {
                expect(underTest!.tiles?.columns).to(equal(5))
                expect(underTest!.tiles?.rows).to(equal(5))
            }
            
            it("is populated with tiles") {
                for column in 0..<5 {
                    for row in 0..<5 {
                        expect(underTest!.tiles[column, row]).notTo(beNil())
                    }
                }
            }
            
            it("has an initial current total of zero") {
                expect(underTest!.currentTotal).to(equal(0))
            }
            
            it("increments the current total if the sprite is not selected") {
                underTest!.tryTouchTileAt(2, row: 1)
                expect(underTest!.currentTotal).to(equal(underTest!.tiles[2,1]!.value))
            }
            
            it("does not increment the current total if the sprite is already selected") {
                underTest!.tryTouchTileAt(2, row: 1)
                underTest!.tryTouchTileAt(2, row: 1)
                expect(underTest!.currentTotal).to(equal(underTest!.tiles[2,1]!.value))
            }
        }
    }
}

