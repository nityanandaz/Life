//
//  Cell.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

@objc
protocol Tickable: NSObjectProtocol {
    func tick(onGrid: Any!, atX x: Int, y: Int) -> Any!
}

class EmptyCell: NSObject {}

extension EmptyCell: Tickable {
    func tick(onGrid: Any!, atX x: Int, y: Int) -> Any! {
        return self
    }
}

class SwiftCell: NSObject {
    static let livingCell = SwiftLivingCell()
    static let deadCell = SwiftDeadCell()
    
    static func living() -> Any! {
        livingCell
    }
    
    static func dead() -> Any! {
        deadCell
    }
    
    func neighbours(onGrid grid: Any!, atX x: Int, y: Int) -> Int! {
        let grid = grid as! Grid
        let neighbours = grid.neighboursOf(x: x, y: y) as! NSArray // NSMutableArray?
        return neighbours
            .value(forKeyPath: "@sum.population") as? Int
    }
}

@objc
extension SwiftCell {
    func potentialStates() -> NSArray {
        fatalError()
    }
    
    func population() -> Int {
        fatalError()
    }
}

extension SwiftCell: Tickable {
    func tick(onGrid grid: Any!, atX x: Int, y: Int) -> Any! {
        potentialStates().object(
            at: neighbours(onGrid: grid, atX: x, y: y))
    }
}


class SwiftLivingCell: SwiftCell {
    static let nextStatesFromLiving = NSArray(array: [
        deadCell,
        deadCell,
        livingCell,
        livingCell,
        deadCell,
        deadCell,
        deadCell,
        deadCell,
        deadCell,
    ])
}

@objc
extension SwiftLivingCell {
    override func potentialStates() -> NSArray {
        Self.nextStatesFromLiving
    }
    
    override func population() -> Int {
        1
    }
    
    func changePopulation() -> Any! {
        Self.dead()
    }
}

class SwiftDeadCell: SwiftCell {
    static let nextStatesFromDead = NSArray(array: [
        deadCell,
        deadCell,
        deadCell,
        livingCell,
        deadCell,
        deadCell,
        deadCell,
        deadCell,
        deadCell,
    ])
}

@objc
extension SwiftDeadCell {
    override func potentialStates() -> NSArray {
        Self.nextStatesFromDead
    }
    
    override func population() -> Int {
        0
    }
    
    func changePopulation() -> Any! {
        Self.living()
    }
}
