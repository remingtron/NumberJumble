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
            
            let underTest = GameViewController()
            
            beforeEach {
                underTest.initialize(SKView())
                underTest.tileTouched(2, row: 3)
            }
            
            it("updates the current total text when a tile is touched") {
                let valueOfTouchedTile = underTest.level.tiles[2, 3]!.value
                expect(underTest.scene.currentTotalLabel.text).to(equal(String(valueOfTouchedTile)))
            }
            
            it("marks the node as last touched in the scene if touched successfully") {
                expect(underTest.scene.gridLayer.tileSprites[2, 3]!.color).to(beSameUIColor(TileSprite.LastTouchedSpriteColor))
            }
            
            it("does not mark the node as touched in the scene if touched unsuccessfully because it's not adjacent") {
                underTest.tileTouched(0, row: 0)
                expect(underTest.scene.gridLayer.tileSprites[0, 0]!.color).to(beSameUIColor(TileSprite.UntouchedSpriteColor))
            }
            
            it("marks the previously selected node as touched in the scene if touched successfully") {
                underTest.tileTouched(3, row: 3)
                expect(underTest.scene.gridLayer.tileSprites[2, 3]!.color).to(beSameUIColor(TileSprite.TouchedSpriteColor))
            }
            
            context("target value is hit") {
                
                var firstTile, secondTile: TileSprite!
                
                beforeEach {
                    firstTile = underTest.scene.gridLayer.tileSprites[2, 3]!
                    secondTile = underTest.scene.gridLayer.tileSprites[3, 3]!
                    underTest.level.targetValue = underTest.level.tiles[2, 3]!.value + underTest.level.tiles[3, 3]!.value
                    underTest.tileTouched(3, row: 3)
                }
                
                it("updates the score") {
                    expect(underTest.scene.scoreLabel.text).to(equal("Score: 1"))
                }
                
                it("resets the current total to 0") {
                    expect(underTest.scene.currentTotalLabel.text).to(equal("0"))
                }
                
                it("replaces tile sprites from selected set") {
                    expect(underTest.scene.gridLayer.tileSprites[2, 3]).notTo(beIdenticalTo(firstTile))
                    expect(underTest.scene.gridLayer.tileSprites[3, 3]).notTo(beIdenticalTo(secondTile))
                }
            }
            
            context("clear button is clicked") {
                
                beforeEach {
                    underTest.tileTouched(1, row: 3)
                    underTest.clearButtonClicked(UIButton())
                }
                
                it("resets all tiles back to untouched state in scene") {
                    expect(underTest.scene.gridLayer.tileSprites[2, 3]!.color).to(beSameUIColor(TileSprite.UntouchedSpriteColor))
                    expect(underTest.scene.gridLayer.tileSprites[1, 3]!.color).to(beSameUIColor(TileSprite.UntouchedSpriteColor))
                }
                
                it("resets the current total to 0 in the scene") {
                    expect(underTest.scene.currentTotalLabel.text).to(equal("0"))
                }
                
                it("resets the current total to 0 in the level") {
                    expect(underTest.level.getCurrentTotal()).to(equal(0))
                }
                
                it("clears selected tiles in level") {
                    expect(underTest.level.getCurrentlySelectedTiles()).to(beEmpty())
                }
                
                it("the same tiles can be reselected") {
                    underTest.tileTouched(2, row: 3)
                    underTest.tileTouched(1, row: 3)
                    
                    expect(underTest.scene.gridLayer.tileSprites[2, 3]!.color).to(beSameUIColor(TileSprite.TouchedSpriteColor))
                    expect(underTest.scene.gridLayer.tileSprites[1, 3]!.color).to(beSameUIColor(TileSprite.LastTouchedSpriteColor))
                }
                
            }
        }
    }
    
}