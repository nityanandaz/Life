//
//  File.swift
//  Life
//
//  Created by Nityananda Zbil on 18.06.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

protocol GridVisitor: AnyObject {
    func visitDenizen(_ denizen: Cell?,
                      onGrid grid: Grid,
                      ofDimension n: Int,
                      atX x: Int,
                      y: Int) -> Cell?
}
