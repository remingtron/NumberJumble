//
//  Level.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/11/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import Foundation

public class Level {
    
    public var tiles: Array2D<Tile>!
    public var currentTotal = 0
    private var mostRecentlySelected: (column: Int, row: Int)?
    
    public init(gridSize: Int) {
        tiles = Array2D<Tile>(columns: gridSize, rows: gridSize)
        for column in 0..<gridSize {
            for row in 0..<gridSize {
                tiles[column, row] = Tile(value: Int(arc4random_uniform(9)+1))
            }
        }
    }
    
    public func tryTouchTileAt(column: Int, row: Int) -> Bool {
        var targetTile = tiles[column, row]!
        if noTilesAreSelected() || (!tiles[column, row]!.isSelected && adjacentToMostRecentlySelectedTile(column, row: row)) {
            currentTotal += targetTile.value
            targetTile.isSelected = true
            mostRecentlySelected = (column, row)
            return true
        }
        return false
    }
    
    private func adjacentToMostRecentlySelectedTile(column: Int, row: Int) -> Bool {
        return (mostRecentlySelected!.column == column-1 && mostRecentlySelected!.row == row) ||
                (mostRecentlySelected!.column == column+1 && mostRecentlySelected!.row == row) ||
                (mostRecentlySelected!.column == column && mostRecentlySelected!.row == row-1) ||
                (mostRecentlySelected!.column == column && mostRecentlySelected!.row == row+1)
    }
    
    private func noTilesAreSelected() -> Bool {
        for column in 0..<tiles.columns {
            for row in 0..<tiles.rows {
                if tiles[column, row]!.isSelected {
                    return false
                }
            }
        }
        return true
    }
}
