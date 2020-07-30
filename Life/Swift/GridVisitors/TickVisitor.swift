//
//  TickVisitor.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

class TickVisitor: NSObject {}

extension TickVisitor: GridVisitor {
    func visitDenizen(_ denizen: NSObject?,
                      onGrid grid: Grid,
                      ofDimension n: Int,
                      atX x: Int,
                      y: Int) -> NSObject {
        return (denizen as? Cell)?
            .tick(onGrid: grid, atX: x, y: y) as! NSObject
    }
}
