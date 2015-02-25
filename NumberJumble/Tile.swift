//
//  Tile.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/11/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import Foundation

public class Tile {
    
    public var value: Int
    public var column: Int
    public var row: Int
    public var isSelected = false
    
    public init(column: Int, row: Int, value: Int) {
        self.column = column
        self.row = row
        self.value = value
    }
    
    public convenience init(column: Int, row: Int) {
        self.init(column: column, row: row, value: Int(arc4random_uniform(9)+1))
    }
}
