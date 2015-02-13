//
//  GameSceneSpec.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/10/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import Quick
import Nimble
import NumberJumble

class GameSceneSpec: QuickSpec {
    
    override func spec() {
        describe("game scene") {
            
            var underTest: GameScene?
            let expectedSize = CGSize(width: 200, height: 300)
            
            beforeEach() {
                underTest = GameScene(size: expectedSize)
            }
            
            it("has the correct size") {
                expect(underTest!.size).to(equal(expectedSize))
            }
            
            it("has the correct background color") {
                expect(underTest!.backgroundColor).to(beSameUIColor(underTest!.colorForBackground))
            }
            
        }
    }
}
