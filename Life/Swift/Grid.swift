//
//  Grid.swift
//  Life
//
//  Created by Nityananda Zbil on 30.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

class Grid: NSObject {
    var n: Int!
    var array: [Any]!
    
    init(sideLength: Int) {
        super.init()
        _ = self._configureWithSideLength(sideLength)
    }
    
    init(sideLength: Int, dwellers: [Any]) {
        super.init()
        _ = self._configureWithSideLength(sideLength, dwellers: dwellers)
    }
    
    func indexFor(x: Int, y: Int) -> Int {
        let n: Int = self.n
        let index = ((x+n)%n)*n + ((y+n)%n)
        
        assert(index >= 0)
        assert(index < n*n)
        
        return index
    }
    
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
        [
            // Vertical
            at(x: x, y: y-1)!,
            at(x: x, y: y+1)!,
            // Horizontal
            at(x: x-1, y: y)!,
            at(x: x+1, y: y)!,
            // Diagonal
            at(x: x-1, y: y-1)!,
            at(x: x-1, y: y+1)!,
            at(x: x+1, y: y-1)!,
            at(x: x+1, y: y+1)!,
        ] as! [Cell]
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
    
    private func at(x: Int, y: Int, put object: NSObject) -> Grid {
        var array = self.array!
        array[self.indexFor(x: x, y: y)] = object
        return Grid(sideLength: n, dwellers: array)
    }
}

private extension Grid {
    func _configureWithSideLength(_ length: Int) -> Grid {
        assert(length > 0)
        
        let empty = EmptyCell()
        let dwellers = Array(repeating: empty,
                             count: length*length)
        
        return _configureWithSideLength(length, dwellers: dwellers)
    }
    
    func _configureWithSideLength(_ length: Int, dwellers: [Any]) -> Grid {
        assert(length > 0)
        assert(dwellers.count == length*length)
        
        self.n = length
        self.array = dwellers
        
        return self
    }
}
