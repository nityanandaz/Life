//
//  Cell.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

protocol Tickable: AnyObject {
    func tick(onGrid: Grid, atX x: Int, y: Int) -> Tickable
}

class Cell: NSObject {
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
}

extension Cell: Tickable {
    func tick(onGrid grid: Grid, atX x: Int, y: Int) -> Tickable {
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
    
    @objc
    func changePopulation() -> Cell {
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
    
    @objc
    func changePopulation() -> Cell {
        Self.livingCell
    }
}
