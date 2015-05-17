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

            var underTest: Level!
            
            beforeEach {
                underTest = Level(gridSize: 5)
            }
            
            it("has a target value that defaults to 15") {
                expect(underTest.targetValue).to(equal(15))
            }
            
            it("has a target value that can be set") {
                underTest.targetValue = 20
                expect(underTest.targetValue).to(equal(20))
            }
            
            it("has a score that defaults to zero") {
                expect(underTest.getScore()).to(equal(0))
            }
            
            it("has a time remaining that defaults to 60") {
                expect(underTest.getTimeRemaining()).to(equal(60))
            }
            
            it("has a grid of tiles") {
                expect(underTest.tiles?.columns).to(equal(5))
                expect(underTest.tiles?.rows).to(equal(5))
            }
            
            it("is populated with tiles") {
                for column in 0..<5 {
                    for row in 0..<5 {
                        expect(underTest.tiles[column, row]).notTo(beNil())
                    }
                }
            }
            
            it("has an initial current total of zero") {
                expect(underTest.getCurrentTotal()).to(equal(0))
            }
            
            it("increments the current total if the sprite is not selected") {
                underTest.tryTouchTileAt(2, row: 1)
                expect(underTest.getCurrentTotal()).to(equal(underTest.tiles[2,1]!.value))
            }
            
            it("is unable to touch tile and does not increment the current total if the sprite is already selected") {
                underTest.tryTouchTileAt(2, row: 1)
                let result = underTest.tryTouchTileAt(2, row: 1)
                expect(result.touchSuccess).to(beFalse())
                expect(underTest.getCurrentTotal()).to(equal(underTest.tiles[2,1]!.value))
            }
            
            it("is able to touch a tile if no tiles have been touched") {
                let result = underTest.tryTouchTileAt(2, row: 1)
                expect(result.touchSuccess).to(beTrue())
            }
            
            it("is unable to touch a tile if at least one tile has been touched and none are adjacent") {
                underTest.tryTouchTileAt(3, row: 3)
                let result = underTest.tryTouchTileAt(2, row: 2)
                expect(result.touchSuccess).to(beFalse())
            }
            
            it("is able to touch a tile if tile to the right is selected") {
                underTest.tryTouchTileAt(3, row: 3)
                let result = underTest.tryTouchTileAt(2, row: 3)
                expect(result.touchSuccess).to(beTrue())
            }
            
            it("is able to touch a tile if tile to the left is selected") {
                underTest.tryTouchTileAt(3, row: 3)
                let result = underTest.tryTouchTileAt(4, row: 3)
                expect(result.touchSuccess).to(beTrue())
            }
            
            it("is able to touch a tile if tile below is selected") {
                underTest.tryTouchTileAt(3, row: 3)
                let result = underTest.tryTouchTileAt(3, row: 4)
                expect(result.touchSuccess).to(beTrue())
            }
            
            it("is able to touch a tile if tile above is selected") {
                underTest.tryTouchTileAt(3, row: 3)
                let result = underTest.tryTouchTileAt(3, row: 2)
                expect(result.touchSuccess).to(beTrue())
            }
            
            it("is unable to touch a tile if the last touched tile is not adjacent, even if an adjacent tile is selected") {
                underTest.tryTouchTileAt(3, row: 3)
                underTest.tryTouchTileAt(3, row: 4)
                let result = underTest.tryTouchTileAt(3, row: 2)
                expect(result.touchSuccess).to(beFalse())
            }
            
            context("when target value is reached") {
                
                var result = (touchSuccess: false, targetHit: false)
                var firstTile, secondTile: Tile!
                
                beforeEach {
                    underTest.newTargetSelector = {
                        return 17
                    }
                    
                    firstTile = underTest.tiles[0, 0]!
                    secondTile = underTest.tiles[0, 1]!
                    underTest.targetValue = underTest.tiles[0, 0]!.value + underTest.tiles[0, 1]!.value
                    underTest.tryTouchTileAt(0, row: 0)
                    result = underTest.tryTouchTileAt(0, row: 1)
                }
                
                it("score is incremented by one") {
                    expect(underTest.getScore()).to(equal(1))
                }
                
                it("selected tiles are cleared") {
                    expect(underTest.getCurrentlySelectedTiles()).to(beEmpty())
                }
                
                it("returns that target was hit") {
                    expect(result.targetHit).to(beTrue())
                }
                
                it("resets current total to zero") {
                    expect(underTest.getCurrentTotal()).to(equal(0))
                }
                
                it("knows which tiles were part of the last target set") {
                    // TODO: convert this to a custom matcher
                    expect(underTest.getLastTargetTiles().count).to(equal(2))
                    expect(underTest.getLastTargetTiles()[0]).to(beIdenticalTo(firstTile))
                    expect(underTest.getLastTargetTiles()[1]).to(beIdenticalTo(secondTile))
                }
                
                it("replaces the selected tiles with new unselected tiles") {
                    let firstNewTile = underTest.tiles[0, 0]!
                    expect(firstNewTile.isSelected).to(beFalse())
                    expect(firstNewTile).notTo(beIdenticalTo(firstTile))
                    expect(firstNewTile.column).to(equal(firstTile.column))
                    expect(firstNewTile.row).to(equal(firstTile.row))
                    
                    let secondNewTile = underTest.tiles[0, 1]!
                    expect(secondNewTile.isSelected).to(beFalse())
                    expect(secondNewTile).notTo(beIdenticalTo(secondTile))
                    expect(secondNewTile.column).to(equal(secondTile.column))
                    expect(secondNewTile.row).to(equal(secondTile.row))
                }
                
                it("resets last target tiles to only include most recent set") {
                    underTest.targetValue = underTest.tiles[2, 2]!.value + underTest.tiles[2, 3]!.value
                    underTest.tryTouchTileAt(2, row: 2)
                    underTest.tryTouchTileAt(2, row: 3)
                    expect(underTest.getLastTargetTiles().count).to(equal(2))
                }
                
                it("sets target value to new random value") {
                    expect(underTest.targetValue).to(equal(17))
                }
            }
        }
    }
}

