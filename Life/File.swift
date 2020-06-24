//
//  File.swift
//  Life
//
//  Created by Nityananda Zbil on 18.06.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

@objc
class SwiftTickVisitor: NSObject {
    @objc
    static func visitor() -> SwiftTickVisitor {
        return SwiftTickVisitor()
    }
}

extension SwiftTickVisitor: GridVisitor {
    func visitDenizen(_ denizen: Any!, onGrid grid: Any!, ofDimension n: Int, atX x: Int, y: Int) -> Any! {
        return (denizen as? Cell)?.tick(onGrid: grid, atX: x, y: y)
    }
}
