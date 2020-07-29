//
//  Cell.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

@objc
protocol CellProtocol: NSObjectProtocol {
    func tick(onGrid: Any!, atX x: Int, y: Int) -> Any!
}

class EmptyCell: NSObject {}

extension EmptyCell: CellProtocol {
    func tick(onGrid: Any!, atX x: Int, y: Int) -> Any! {
        return self
    }
}
