//
//  GridLayer.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/15/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import SpriteKit

public class GridLayer: SKNode {
    
    private let TileSize = CGFloat(100.0)
    public var tileSprites: Array2D<TileSprite>!
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    public init(tiles: Array2D<Tile>) {
        super.init()
        tileSprites = Array2D<TileSprite>(columns: tiles.columns, rows: tiles.rows)
        
        for row in 0..<tiles.rows {
            for column in 0..<tiles.columns {
                let tile = TileSprite(value: tiles[column, row]!.value, size: TileSize)
                tile.position = CGPoint(x: coordinateFor(column, total: tiles.columns), y: coordinateFor(row, total: tiles.rows))
                addChild(tile)
                tileSprites[column, row] = tile
            }
        }
    }
    
    private func coordinateFor(index: Int, total: Int) -> CGFloat {
        let tilesOnEachSideOfMiddle = (CGFloat(total)-1.0)/2.0
        return CGFloat(TileSize)*(CGFloat(index)-tilesOnEachSideOfMiddle)
    }
    
    public func tileAtPoint(location: CGPoint) -> (tileFound: Bool, column: Int, row: Int) {
        for row in 0..<tileSprites.rows {
            for column in 0..<tileSprites.columns {
                if tileSprites[column, row]!.containsPoint(location) {
                    return (true, column, row)
                }
            }
        }
        return (false, -1, -1)
    }
}
