//
//  Grid+Neighbours.swift
//  Life
//
//  Created by Nityananda Zbil on 30.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

@objc
extension Grid {
    func _verticalNeighboursOfX(_ x: Int, y: Int) -> NSArray {
        [
            at(x: x, y: y-1)!,
            at(x: x, y: y+1)!,
        ]
    }
    
    func _horizontalNeighboursOfX(_ x: Int, y: Int) -> NSArray {
        [
            at(x: x-1, y: y)!,
            at(x: x+1, y: y)!,
        ]
    }
    
    func _diagonalNeighboursOfX(_ x: Int, y: Int) -> NSArray {
        [
            at(x: x-1, y: y-1)!,
            at(x: x-1, y: y+1)!,
            at(x: x+1, y: y-1)!,
            at(x: x+1, y: y+1)!,
        ]
    }
}
