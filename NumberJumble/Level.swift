//
//  Level.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/11/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import Foundation

public class Level {
    
    // public for testing?
    public var targetValue = 15
    public var tiles: Array2D<Tile>!
    public var newTargetSelector = {
        return Int(arc4random_uniform(10)+10)
    }
    
    private var currentTotal = 0
    private var selectedTiles = Array<Tile>()
    private var lastTargetTiles = Array<Tile>()
    private var score = 0
    private var timeRemaining: Int
    private var useChainLengthScoring: Bool
    
    public init(gridSize: Int, length: Int, useChainLengthScoring: Bool = false) {
        tiles = Array2D<Tile>(columns: gridSize, rows: gridSize)
        for column in 0..<gridSize {
            for row in 0..<gridSize {
                tiles[column, row] = Tile(column: column, row: row)
            }
        }
        self.timeRemaining = length
        self.useChainLengthScoring = useChainLengthScoring
    }
    
    public func tryTouchTileAt(column: Int, row: Int) -> (touchSuccess: Bool, targetHit: Bool) {
        let targetTile = tiles[column, row]!
        if noTilesAreSelected() || (!tiles[column, row]!.isSelected && adjacentToMostRecentlySelectedTile(column, row: row)) {
            currentTotal += targetTile.value
            targetTile.isSelected = true
            selectedTiles.append(tiles[column, row]!)
            return (true, checkForTargetValue())
        }
        return (false, false)
    }
    
    private func checkForTargetValue() -> Bool {
        let targetHit = (currentTotal == targetValue)
        if targetHit {
            score += chainValue(selectedTiles.count)
            moveSelectedTilesToLastTargetTiles()
            currentTotal = 0
            targetValue = newTargetSelector()
        }
        return targetHit
    }
    
    private func chainValue(length: Int) -> Int {
        if !useChainLengthScoring { return 1 }
        return Int(pow(Double(2), Double(min(3, length - 2))))
    }
    
    private func moveSelectedTilesToLastTargetTiles() {
        lastTargetTiles.removeAll()
        
        for tile in selectedTiles {
            tiles[tile.column, tile.row] = Tile(column: tile.column, row: tile.row)
            lastTargetTiles.append(tile)
        }
        
        selectedTiles.removeAll()
    }
    
    private func adjacentToMostRecentlySelectedTile(column: Int, row: Int) -> Bool {
        let mostRecentlySelected = selectedTiles[selectedTiles.count-1]
        return (mostRecentlySelected.column == column-1 && mostRecentlySelected.row == row) ||
                (mostRecentlySelected.column == column+1 && mostRecentlySelected.row == row) ||
                (mostRecentlySelected.column == column && mostRecentlySelected.row == row-1) ||
                (mostRecentlySelected.column == column && mostRecentlySelected.row == row+1)
    }
    
    private func noTilesAreSelected() -> Bool {
        return selectedTiles.count == 0
    }
    
    public func getScore() -> Int {
        return score
    }
    
    public func getTimeRemaining() -> Int {
        return timeRemaining
    }
    
    public func setTimeRemaining(timeRemaining: Int) {
        self.timeRemaining = timeRemaining
    }
    
    public func getCurrentTotal() -> Int {
        return currentTotal
    }
    
    public func getCurrentlySelectedTiles() -> Array<Tile> {
        return selectedTiles
    }
    
    public func getLastTargetTiles() -> Array<Tile> {
        return lastTargetTiles
    }
    
    public func resetSelections() {
        currentTotal = 0
        for tile in selectedTiles {
            tile.isSelected = false
        }
        selectedTiles.removeAll()
    }
    
    public func timerFire() {
        timeRemaining--
    }
    
    public func isUsingChainLengthScoring() -> Bool {
        return useChainLengthScoring
    }
}
