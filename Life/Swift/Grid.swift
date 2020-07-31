//
//  Grid.swift
//  Life
//
//  Created by Nityananda Zbil on 30.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

final class Grid {
    var n: Int
    var array: [CellProtocol?]
    
    init(sideLength: Int, dwellers: [CellProtocol?]) {
        assert(sideLength > 0)
        assert(dwellers.count == sideLength*sideLength)
        
        self.n = sideLength
        self.array = dwellers
    }
    
    func indexFor(x: Int, y: Int) -> Int {
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
        
        let dwellers = Array<CellProtocol?>(repeating: nil,
                             count: sideLength*sideLength)
        self.init(sideLength: sideLength, dwellers: dwellers)
    }
}

extension Grid {
    func fill(with denizen: CellProtocol) -> Grid {
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
    
    func neighboursOf(x: Int, y: Int) -> [CellProtocol] {
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
    
    func at(x: Int, y: Int) -> CellProtocol? {
        array[self.indexFor(x: x, y: y)]
    }
    
    func at(x: Int, y: Int, perform action: (CellProtocol?) -> CellProtocol?) -> Grid {
        return at(x: x, y: y, put:
                    action(at(x: x, y: y)))
    }
    
    private func at(x: Int, y: Int, put object: CellProtocol?) -> Grid {
        array[self.indexFor(x: x, y: y)] = object
        return Grid(sideLength: n, dwellers: array)
    }
}
