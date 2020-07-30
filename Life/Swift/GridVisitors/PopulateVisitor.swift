//
//  PopulateVisitor.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

class PopulateVisitor: NSObject {
    var replacementDenizen: Cell
    
    init(replacementDenizen: Cell) {
        self.replacementDenizen = replacementDenizen
    }
}

extension PopulateVisitor: GridVisitor {
    func visitDenizen(_ denizen: NSObject?,
                      onGrid grid: Grid,
                      ofDimension n: Int,
                      atX x: Int,
                      y: Int) -> NSObject {
        return replacementDenizen
    }
}
