//
//  Cell.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

// MARK: - Cell
protocol Cell: AnyObject {
    var population: Int { get }
    var potentialStates: [Cell] { get }
    
    func changePopulation() -> Cell
    func tickOn(grid: Grid, atX x: Int, y: Int) -> Cell
}

extension Cell where Self: AbstractCell {
    func tickOn(grid: Grid, atX x: Int, y: Int) -> Cell {
        potentialStates[neighbours(onGrid: grid, atX: x, y: y)]
    }
}

// MARK: - AbstractCell
class AbstractCell {
    static let livingCell = LivingCell()
    static let deadCell = DeadCell()
    
    func neighbours(onGrid grid: Grid, atX x: Int, y: Int) -> Int {
        grid.neighboursOf(x: x, y: y)
            .map(\.population)
            .reduce(0, +)
    }
}

// MARK: - LivingCell
final class LivingCell: AbstractCell, Cell {
    static let nextStatesFromLiving: [Cell] = [
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
    
    var potentialStates: [Cell] {
        Self.nextStatesFromLiving
    }
    
    func changePopulation() -> Cell {
        Self.deadCell
    }
}

// MARK: - DeadCell
final class DeadCell: AbstractCell, Cell {
    static let nextStatesFromDead: [Cell] = [
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
    
    var potentialStates: [Cell] {
        Self.nextStatesFromDead
    }
    
    func changePopulation() -> Cell {
        Self.livingCell
    }
}
