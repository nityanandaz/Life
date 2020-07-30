//
//  Grid.swift
//  Life
//
//  Created by Nityananda Zbil on 30.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

extension Grid {
    func fill(with denizen: Cell) -> Grid {
        self.visit(PopulateVisitor(
                    replacementDenizen: denizen))
    }
    
    func tick() -> Any! {
        self.visit(TickVisitor())
    }
    
    func visit(_ visitor: GridVisitor) -> Grid {
        let visitazion = Visitation(grid: self,
                                    dimension: n,
                                    visitor: visitor)
        (1...n*n).forEach { (_) in
            _ = visitazion.visitNext()
        }
        return visitazion.visitedGrid()
    }
    
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

@objc
extension Grid {
    func at(x: Int, y: Int, put object: NSObject) -> Grid {
        var array = self.array!
        array[self.indexFor(x: x, y: y)] = object
        return Grid(sideLength: n, dwellers: array)
    }
    
    func at(x: Int, y: Int) -> NSObject? {
        let array = self.array as! [NSObject]
        let result = array[self.indexFor(x: x, y: y)]
        return result.isKind(of: EmptyCell.self)
            ? nil
            : result
    }
    
    func at(x: Int, y: Int, perform selector: Selector) -> Any! {
        let object = at(x: x, y: y)?
            .perform(selector)?
            .takeUnretainedValue() as! Cell
        return at(x: x, y: y, put: object)
    }
}
