//
//  LifeController.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

class LifeController: NSObject {
    private static let gridSize: NSInteger = 15
    
    var grid: Grid!
    var gridView: GridView!
    
    override func awakeFromNib() {
        grid = (Grid.withSideLength(Self.gridSize) as? Grid)?
            .fill(with: Cell.dead()) as? Grid
    }
    
    @objc
    func changeCellAtRelativeX(_ fractionX: Float, y fractionY: Float) -> Any! {
        let cellX = Int(fractionX * Float(Self.gridSize))
        let cellY = Int(fractionY * Float(Self.gridSize))
        
        grid = grid.at(x: cellX,
                       y: cellY,
                       perform: NSSelectorFromString("changePopulation")) as? Grid
        gridView.drawGrid(grid)
        
        return self
    }
}

extension LifeController {
    @IBAction func tick(_ sender: Any) {
        grid = grid.tick() as? Grid
        gridView.drawGrid(grid)
    }
}
