//
//  LifeController.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

final class LifeController: NSObject {
    private static let gridSize: NSInteger = 15
    
    var grid: Grid
    var gridView: GridView
    
    init(gridView: GridView) {
        self.grid = (Grid.withSideLength(Self.gridSize) as? Grid)?
            .fill(with: Cell.dead()) as! Grid
        self.gridView = gridView
        
        _ = self.gridView.drawGrid(grid)
    }
    
    func changeCellAtRelativeX(_ fractionX: Float, y fractionY: Float) -> Self {
        let cellX = Int(fractionX * Float(Self.gridSize))
        let cellY = Int(fractionY * Float(Self.gridSize))
        
        grid = grid.at(x: cellX,
                       y: cellY,
                       perform: NSSelectorFromString("changePopulation")) as! Grid
        _ = gridView.drawGrid(grid)
        
        return self
    }
}

extension LifeController {
    @IBAction func tick(_ sender: Any) {
        grid = grid.tick() as! Grid
        _ = gridView.drawGrid(grid)
    }
}
