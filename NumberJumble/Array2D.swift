//
//  Array2D.swift
//  CookieCrunch
//
//  Created by Remington Davenport on 2/7/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

public struct Array2D<T> {
    public let columns: Int
    public let rows: Int
    private var array: Array<T?>
    
    public init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(count: rows*columns, repeatedValue: nil)
    }
    
    public subscript(column: Int, row: Int) -> T? {
        get {
            assert(column >= 0 && column < columns)
            assert(row >= 0 && row < rows)
            return array[row*columns + column]
        }
        set {
            assert(column >= 0 && column < columns)
            assert(row >= 0 && row < rows)
            array[row*columns + column] = newValue
        }
    }
}
