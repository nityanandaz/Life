//
//  Visitation.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

final class Visitation {
    var allVisited: [CellProtocol?]
    var grid: Grid
    var visitor: GridVisitor
    
    var cursor: Int
    var dimension: Int
    
    init(grid: Grid, dimension: Int, visitor: GridVisitor) {
        self.allVisited = []
        self.grid = grid
        self.visitor = visitor
        
        self.cursor = 0
        self.dimension = dimension
    }
    
    func visitNext() -> CellProtocol? {
        let x = cursor / dimension
        let y = cursor % dimension
        cursor += 1
        let visited = visitor.visitDenizen(
            grid.at(x: x, y: y),
            onGrid: grid,
            ofDimension: dimension,
            atX: x,
            y: y)
        allVisited.append(visited)
        return visited
    }
    
    func visitedGrid() -> Grid {
        return Grid(sideLength: dimension,
                    dwellers: allVisited)
    }
}
