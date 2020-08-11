//
//  Visitation.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

final class Visitation {
    private let grid: Grid
    private let dimension: Int
    private let visitor: GridVisitor
    
    private var cursor: Int
    private var allVisited: [Cell?]
    
    init(grid: Grid, dimension: Int, visitor: GridVisitor) {
        self.allVisited = []
        self.grid = grid
        self.visitor = visitor
        
        self.cursor = 0
        self.dimension = dimension
    }
    
    func visitNext() -> Cell? {
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
