//
//  Level.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/11/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import Foundation

public class Level {
    
    public var targetValue = 15
    public var tiles: Array2D<Tile>!
    private var currentTotal = 0
    private var selectedTiles = Array<Tile>()
    
    public init(gridSize: Int) {
        tiles = Array2D<Tile>(columns: gridSize, rows: gridSize)
        for column in 0..<gridSize {
            for row in 0..<gridSize {
                tiles[column, row] = Tile(column: column, row: row, value: Int(arc4random_uniform(9)+1))
            }
        }
    }
    
    public func tryTouchTileAt(column: Int, row: Int) -> Bool {
        var targetTile = tiles[column, row]!
        if noTilesAreSelected() || (!tiles[column, row]!.isSelected && adjacentToMostRecentlySelectedTile(column, row: row)) {
            currentTotal += targetTile.value
            targetTile.isSelected = true
            selectedTiles.append(tiles[column, row]!)
            return true
        }
        return false
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
    
    public func getCurrentTotal() -> Int {
        return currentTotal
    }
    
    public func getCurrentlySelectedTiles() -> Array<Tile> {
        return selectedTiles
    }
}
