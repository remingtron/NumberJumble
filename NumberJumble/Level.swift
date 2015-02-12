//
//  Level.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/11/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

public class Level {
    
    public var tiles: Array2D<Tile>!
    
    public init(gridSize: Int) {
        tiles = Array2D<Tile>(columns: gridSize, rows: gridSize)
    }
}
