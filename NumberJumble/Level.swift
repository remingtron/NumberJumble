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
        if noTilesAreSelected() || (!tiles[column, row]!.isSelected && adjacentTileIsSelected(column, row: row)) {
            currentTotal += targetTile.value
            targetTile.isSelected = true
            return true
        }
        return false
    }
    
    private func adjacentTileIsSelected(column: Int, row: Int) -> Bool {
        return (tiles[column-1, row]?.isSelected ?? false) ||
                (tiles[column+1, row]?.isSelected ?? false) ||
                (tiles[column, row-1]?.isSelected ?? false) ||
                (tiles[column, row+1]?.isSelected ?? false)
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
