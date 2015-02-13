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
            it("has a grid of tiles") {
                let underTest = Level(gridSize: 5)
                expect(underTest.tiles?.columns).to(equal(5))
                expect(underTest.tiles?.rows).to(equal(5))
            }
        }
    }
}
