//
//  File.swift
//  Life
//
//  Created by Nityananda Zbil on 18.06.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

@objc protocol GridVisitor: NSObjectProtocol {
    func visitDenizen(_ denizen: Any!,
                      onGrid grid: Grid,
                      ofDimension n: Int,
                      atX x: Int,
                      y: Int) -> Any!
}
