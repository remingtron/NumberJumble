//
//  Array2DSpec.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/11/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import Quick
import Nimble
import NumberJumble

class Array2DSpec: QuickSpec {
    override func spec() {
        describe("2d array") {
            
            var underTest = Array2D<Int>(columns: 2, rows: 3)
            
            it("has columns") {
                expect(underTest.columns).to(equal(2))
            }
            
            it("has rows") {
                expect(underTest.rows).to(equal(3))
            }
            
            it("is initially filled with nils") {
                for column in 0..<2 {
                    for row in 0..<3 {
                        expect(underTest[column, row]).to(beNil())
                    }
                }
            }
            
            it("can hold values") {
                underTest[1,2] = 4
                expect(underTest[1,2]).to(equal(4))
            }
            
            // disabling test since swift doesn't have a way of catching exceptions
            xit("throws an error if accessing outside column boundaries") {
                underTest[-1,1] = 1
            }
            
        }
    }
}
