//
//  TickVisitor.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

class TickVisitor: NSObject {}

@objc
extension TickVisitor {
    static func visitor() -> TickVisitor {
        return TickVisitor()
    }
}

extension TickVisitor: GridVisitor {
    func visitDenizen(_ denizen: Any!,
                      onGrid grid: Any!,
                      ofDimension n: Int,
                      atX x: Int,
                      y: Int) -> Any! {
        return (denizen as? SwiftCell)?.tick(onGrid: grid, atX: x, y: y)
    }
}
