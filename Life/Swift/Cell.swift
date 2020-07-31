//
//  Cell.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

class Cell {
    static let livingCell = LivingCell()
    static let deadCell = DeadCell()
    
    var population: Int {
        fatalError()
    }
    
    func neighbours(onGrid grid: Grid, atX x: Int, y: Int) -> Int {
        grid.neighboursOf(x: x, y: y)
            .map(\.population)
            .reduce(0, +)
    }
    
    func potentialStates() -> [Cell] {
        fatalError()
    }
    
    func changePopulation() -> Cell {
        fatalError()
    }
}

extension Cell {
    func tick(onGrid grid: Grid, atX x: Int, y: Int) -> Cell {
        potentialStates()[neighbours(onGrid: grid, atX: x, y: y)]
    }
}


class LivingCell: Cell {
    static let nextStatesFromLiving = [
        deadCell,
        deadCell,
        livingCell,
        livingCell,
        deadCell,
        deadCell,
        deadCell,
        deadCell,
        deadCell,
    ]
    
    override var population: Int { 1 }
    
    override func potentialStates() -> [Cell] {
        Self.nextStatesFromLiving
    }
    
    override func changePopulation() -> Cell {
        Self.deadCell
    }
}

class DeadCell: Cell {
    static let nextStatesFromDead = [
        deadCell,
        deadCell,
        deadCell,
        livingCell,
        deadCell,
        deadCell,
        deadCell,
        deadCell,
        deadCell,
    ]
    
    override var population: Int { 0 }
    
    override func potentialStates() -> [Cell] {
        Self.nextStatesFromDead
    }
    
    override func changePopulation() -> Cell {
        Self.livingCell
    }
}
