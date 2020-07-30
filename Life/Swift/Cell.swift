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

class EmptyCell: NSObject {}

extension EmptyCell: Tickable {
    func tick(onGrid: Grid, atX x: Int, y: Int) -> Tickable {
        return self
    }
}

class Cell: NSObject {
    static let livingCell = LivingCell()
    static let deadCell = DeadCell()
    
    func neighbours(onGrid grid: Any!, atX x: Int, y: Int) -> Int! {
        let grid = grid as! Grid
        let neighbours = grid.neighboursOf(x: x, y: y) as! NSArray // NSMutableArray?
        return neighbours
            .value(forKeyPath: "@sum.population") as? Int
    }
    
    func potentialStates() -> [Cell] {
        fatalError()
    }
    
    func population() -> Int {
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
    
    override func potentialStates() -> [Cell] {
        Self.nextStatesFromLiving
    }
    
    @objc
    override func population() -> Int {
        1
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
    
    override func potentialStates() -> [Cell] {
        Self.nextStatesFromDead
    }
    
    @objc
    override func population() -> Int {
        0
    }
    
    @objc
    func changePopulation() -> Cell {
        Self.livingCell
    }
}
