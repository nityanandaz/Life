//
//  Cell.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

// MARK: - Cell
class Cell {
    static let livingCell = LivingCell()
    static let deadCell = DeadCell()
    
    func neighbours(onGrid grid: Grid, atX x: Int, y: Int) -> Int {
        grid.neighboursOf(x: x, y: y)
            .map(\.population)
            .reduce(0, +)
    }
}

// MARK: - CellProtocol
protocol CellProtocol: AnyObject {
    var population: Int { get }
    var potentialStates: [CellProtocol] { get }
    
    func changePopulation() -> CellProtocol
    func tickOn(grid: Grid, atX x: Int, y: Int) -> CellProtocol
}

extension CellProtocol where Self: Cell {
    func tickOn(grid: Grid, atX x: Int, y: Int) -> CellProtocol {
        potentialStates[neighbours(onGrid: grid, atX: x, y: y)]
    }
}

// MARK: - LivingCell
final class LivingCell: Cell, CellProtocol {
    static let nextStatesFromLiving: [CellProtocol] = [
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
    
    var population: Int { 1 }
    
    var potentialStates: [CellProtocol] {
        Self.nextStatesFromLiving
    }
    
    func changePopulation() -> CellProtocol {
        Self.deadCell
    }
}

// MARK: - DeadCell
final class DeadCell: Cell, CellProtocol {
    static let nextStatesFromDead: [CellProtocol] = [
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
    
    var population: Int { 0 }
    
    var potentialStates: [CellProtocol] {
        Self.nextStatesFromDead
    }
    
    func changePopulation() -> CellProtocol {
        Self.livingCell
    }
}
