//
//  TickVisitor.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

final class TickVisitor {}

extension TickVisitor: GridVisitor {
    func visitDenizen(_ denizen: Cell?,
                      onGrid grid: Grid,
                      ofDimension n: Int,
                      atX x: Int,
                      y: Int) -> Cell? {
        denizen?.tickOn(grid: grid, atX: x, y: y)
    }
}
