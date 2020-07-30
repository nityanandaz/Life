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
    func neighboursOf(x: Int, y: Int) -> [Cell] {
        [ // Vertical
            at(x: x, y: y-1)!,
            at(x: x, y: y+1)!,
        ] + [ // Horizontal
            at(x: x-1, y: y)!,
            at(x: x+1, y: y)!,
        ] + [ // Diagonal
            at(x: x-1, y: y-1)!,
            at(x: x-1, y: y+1)!,
            at(x: x+1, y: y-1)!,
            at(x: x+1, y: y+1)!,
        ] as! [Cell]
    }
}
