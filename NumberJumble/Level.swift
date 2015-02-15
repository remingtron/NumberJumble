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
    
    public func tryTouchTileAt(column: Int, row: Int) {
        var targetTile = tiles[column, row]!
        if !targetTile.isSelected {
            currentTotal += tiles[column, row]!.value
            tiles[column, row]!.isSelected = true
        }
    }
}
