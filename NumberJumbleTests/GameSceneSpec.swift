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
            
            func getColorComponents(color: UIColor) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
                var redValue = CGFloat(0.0), greenValue = CGFloat(0.0), blueValue = CGFloat(0.0), alphaValue = CGFloat(0.0)
                color.getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alphaValue)
                return (redValue, greenValue, blueValue, alphaValue)
            }
            
            it("has the correct background color") {
                let backgroundColorComponents = getColorComponents(underTest!.backgroundColor)
                let expectedColorComponents = getColorComponents(underTest!.colorForBackground)
                let delta = 0.01
                
                expect(backgroundColorComponents.red).to(beCloseTo(expectedColorComponents.red, within: delta))
                expect(backgroundColorComponents.green).to(beCloseTo(expectedColorComponents.green, within: delta))
                expect(backgroundColorComponents.blue).to(beCloseTo(expectedColorComponents.blue, within: delta))
                expect(backgroundColorComponents.alpha).to(beCloseTo(expectedColorComponents.alpha, within: delta))
            }
            
        }
    }
}
