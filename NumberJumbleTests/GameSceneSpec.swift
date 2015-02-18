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
import SpriteKit

class GameSceneSpec: QuickSpec {
    
    override func spec() {
        describe("game scene") {
            
            let expectedSize = CGSize(width: 200, height: 300)
            
            let level = Level(gridSize: 6)
            level.targetValue = 18
            
            let underTest = GameScene(size: expectedSize, level: level)
            
            it("has the correct size") {
                expect(underTest.size).to(equal(expectedSize))
            }
            
            it("has the correct background color") {
                expect(underTest.backgroundColor).to(beSameUIColor(underTest.colorForBackground))
            }
            
            it("has an anchor point in the middle") {
                expect(underTest.anchorPoint).to(equal(CGPoint(x: 0.5, y: 0.5)))
            }
            
            context("grid layer") {
                
                let gridLayer = underTest.childNodeWithName("gridLayer") as GridLayer
                
                it("has tiles in the grid layer") {
                    expect(gridLayer.children.count).to(equal(36))
                }
                
                it("positions the tile sprites correctly") {
                    expect(gridLayer.tileSprites![0, 0]!.position).to(equal(CGPoint(x: -250, y: -250)))
                    expect(gridLayer.tileSprites![2, 3]!.position).to(equal(CGPoint(x: -50, y: 50)))
                    expect(gridLayer.tileSprites![5, 5]!.position).to(equal(CGPoint(x: 250, y: 250)))
                }
            }
            
            context("current total label") {
                
                let currentTotalLabel = underTest.childNodeWithName("currentTotal") as SKLabelNode
                
                it("has an initial value of 0") {
                    expect(currentTotalLabel.text).to(equal("0"))
                }
                
                it("has the correct font settings") {
                    expect(currentTotalLabel.fontName).to(equal("GillSans-Bold"))
                    expect(currentTotalLabel.fontColor).to(beSameUIColor(UIColor.whiteColor()))
                    expect(currentTotalLabel.fontSize).to(equal(100))
                }
                
                it("has the correct position") {
                    expect(currentTotalLabel.position).to(equal(CGPoint(x: 0, y: 375)))
                }
            }
            
            context("target total label") {
                
                let targetTotal = underTest.childNodeWithName("targetTotal") as SKLabelNode
                
                it("has the correct text") {
                    expect(targetTotal.text).to(equal("Target: 18"))
                }
                
                it("has the correct font settings") {
                    expect(targetTotal.fontName).to(equal("GillSans-Bold"))
                    expect(targetTotal.fontColor).to(beSameUIColor(UIColor.whiteColor()))
                    expect(targetTotal.fontSize).to(equal(80))
                }
                
                it("has the correct position") {
                    expect(targetTotal.position).to(equal(CGPoint(x: 0, y: -390)))
                }
            }
            
            context("score label") {
                
                let scoreLabel = underTest.childNodeWithName("score") as SKLabelNode
                
                it("has the correct text") {
                    expect(scoreLabel.text).to(equal("Score: 0"))
                }
                
                it("has the correct font settings") {
                    expect(scoreLabel.fontName).to(equal("GillSans-Bold"))
                    expect(scoreLabel.fontColor).to(beSameUIColor(UIColor.whiteColor()))
                    expect(scoreLabel.fontSize).to(equal(80))
                }
                
                it("has the correct position") {
                    expect(scoreLabel.position).to(equal(CGPoint(x: 0, y: -475)))
                }
            }
            
            it("calls tileTouchedHandler with sprite coordinates if sprite is touched") {
                
                var capturedColumn: Int?
                var capturedRow: Int?
                
                underTest.tileTouchedHandler = { (column: Int, row: Int) in
                    capturedColumn = column
                    capturedRow = row
                }
                
                underTest.touchHandler(CGPoint(x: 50, y: -150))
                expect(capturedColumn?).to(equal(3))
                expect(capturedRow?).to(equal(1))
            }
            
            it("does not call tileTouchHandler if area outside sprites in touched") {
                
                var capturedColumn: Int?
                var capturedRow: Int?
                
                underTest.tileTouchedHandler = { (column: Int, row: Int) in
                    capturedColumn = column
                    capturedRow = row
                }
                
                underTest.touchHandler(CGPoint(x: -500, y: 300))
                expect(capturedColumn?).to(beNil())
                expect(capturedRow?).to(beNil())
            }
        }
    }
}
