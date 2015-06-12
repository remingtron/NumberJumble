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
    
    override func setUp() {
        continueAfterFailure = false
    }
    
    override func spec() {
        describe("game view controller") {
            
            let underTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("gameViewController") as! GameViewController
            let window = UIWindow(frame: UIScreen().bounds)
            
            beforeEach {
                window.rootViewController = underTest
                window.makeKeyAndVisible()
                
                underTest.view = SKView()
                underTest.setupGame(SKView())
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
                    let nextTarget = underTest.level.tiles[2, 3]!.value + underTest.level.tiles[3, 3]!.value + 1
                    underTest.level.newTargetSelector = {
                        return nextTarget
                    }
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
                
                it("updates current target") {
                    expect(underTest.scene.targetTotalLabel.text).to(equal("Target: \(underTest.level.targetValue)"))
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
            
            context("game starts") {
                
                beforeEach {
                    underTest.startGame()
                }
                
                it("starts the timer when the game starts") {
                    expect(underTest.timer.valid).to(beTrue())
                }
                
                it("timer interval is one second") {
                    expect(underTest.timer.timeInterval).to(equal(1.0))
                }
                
            }
            
            context("timer fires") {
                
                beforeEach {
                    underTest.timerFire()
                }
                
                it("decrements time reamining by 1") {
                    expect(underTest.level.getTimeRemaining()).to(equal(59))
                }
                
                it("decrements time each time it is fired") {
                    underTest.timerFire()
                    expect(underTest.level.getTimeRemaining()).to(equal(58))
                }
                
                it("updates timer label with time remaining") {
                    expect(underTest.scene.timerLabel.text).to(equal(String(underTest.level.getTimeRemaining())))
                }
                
            }
            
            context("timer reaches 0") {
                
                beforeEach {
                    underTest.startGame()
                    
                    for i in 1...60 {
                        underTest.timerFire()
                    }
                }
                
                it("invalidates the current timer") {
                    expect(underTest.timer.valid).to(beFalse())
                }
                
                it("presents the game over screen") {
                    expect(underTest.presentedViewController?.restorationIdentifier).to(equal("endController"))
                }
                
            }
        }
    }
    
}