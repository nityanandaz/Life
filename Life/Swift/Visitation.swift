//
//  Visitation.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

class Visitation: NSObject {
    var allVisited: NSMutableArray
    var grid: Grid
    var visitor: GridVisitor
    
    var cursor: Int
    var dimension: Int
    
    @objc
    init(grid: Grid, dimension: Int, visitor: GridVisitor) {
        self.allVisited = NSMutableArray()
        self.grid = grid
        self.visitor = visitor
        
        self.cursor = 0
        self.dimension = dimension
    }
}

@objc
extension Visitation {
    func visitNext() -> Any! {
        let x = cursor / dimension
        let y = cursor % dimension
        cursor += 1
        let visited = visitor.visitDenizen(
            grid.at(x: x, y: y),
            onGrid: grid,
            ofDimension: dimension,
            atX: x,
            y: y)
        allVisited.add(visited!)
        return visited
    }
    
    func visitedGrid() -> Grid {
        return Grid(sideLength: dimension,
                    dwellers: allVisited as! [NSObject])
    }
}
