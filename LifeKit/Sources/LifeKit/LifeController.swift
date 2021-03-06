//
//  LifeController.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

public final class LifeController: NSObject {
    private static let gridSize: CGFloat = 15.0
    
    var grid: Grid
    var gridView: GridView
    
    public init(gridView: GridView) {
        self.grid = Grid(sideLength: Int(Self.gridSize))
            .fill(with: AbstractCell.deadCell)
        self.gridView = gridView
        
        _ = self.gridView.drawGrid(grid)
    }
    
    func changeCellAtRelative(x fractionX: CGFloat, y fractionY: CGFloat) -> Self {
        let cellX = Int(fractionX * Self.gridSize)
        let cellY = Int(fractionY * Self.gridSize)
        
        grid = grid.at(x: cellX, y: cellY, perform: {
            $0?.changePopulation()
        })
        _ = gridView.drawGrid(grid)
        
        return self
    }
}

public extension LifeController {
    @IBAction func tick(_ sender: Any) {
        grid = grid.tick()
        _ = gridView.drawGrid(grid)
    }
}
