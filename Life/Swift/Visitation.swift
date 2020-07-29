//
//  Visitation.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

class Visitation: NSObject {
    var allVisited: NSMutableArray!
    var grid: Grid!
    var visitor: GridVisitor!
    
    var cursor: Int = 0
    var dimension: Int = 0
}

@objc
extension Visitation {
    static func visitation(onGrid grid: Any!,
                           ofDimension dimension: Int,
                           byVisitor visitor: Any!) -> Visitation {
        let grid = grid as! Grid
        let visitor = visitor as! GridVisitor
        
        let visitation = Visitation()
        visitation.allVisited = NSMutableArray()
        visitation.grid = grid
        visitation.visitor = visitor
        visitation.cursor = 0
        visitation.dimension = dimension
        
        return visitation
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
    
    func visitedGrid() -> Any! {
        return Grid(sideLength: dimension,
                    dwellers: allVisited)
    }
}
