//
//  Grid.swift
//  Life
//
//  Created by Nityananda Zbil on 30.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

final class Grid {
    private let n: Int
    var array: [Cell?]
    
    init(sideLength: Int, dwellers: [Cell?]) {
        assert(sideLength > 0)
        assert(dwellers.count == sideLength*sideLength)
        
        self.n = sideLength
        self.array = dwellers
    }
    
    private func indexFor(x: Int, y: Int) -> Int {
        let n: Int = self.n
        let index = ((x+n)%n)*n + ((y+n)%n)
        
        assert(index >= 0)
        assert(index < n*n)
        
        return index
    }
    
}

extension Grid {
    convenience init(sideLength: Int) {
        assert(sideLength > 0)
        
        let dwellers = Array<Cell?>(repeating: nil,
                             count: sideLength*sideLength)
        self.init(sideLength: sideLength, dwellers: dwellers)
    }
}

extension Grid {
    func fill(with denizen: Cell) -> Grid {
        self.visit(PopulateVisitor(
                    replacementDenizen: denizen))
    }
    
    func tick() -> Grid {
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
        [
            // Vertical
            at(x: x, y: y-1),
            at(x: x, y: y+1),
            // Horizontal
            at(x: x-1, y: y),
            at(x: x+1, y: y),
            // Diagonal
            at(x: x-1, y: y-1),
            at(x: x-1, y: y+1),
            at(x: x+1, y: y-1),
            at(x: x+1, y: y+1),
        ].compactMap({ $0 })
    }
    
    func at(x: Int, y: Int) -> Cell? {
        array[self.indexFor(x: x, y: y)]
    }
    
    func at(x: Int, y: Int, perform action: (Cell?) -> Cell?) -> Grid {
        return at(x: x, y: y, put:
                    action(at(x: x, y: y)))
    }
    
    private func at(x: Int, y: Int, put object: Cell?) -> Grid {
        array[self.indexFor(x: x, y: y)] = object
        return Grid(sideLength: n, dwellers: array)
    }
}
