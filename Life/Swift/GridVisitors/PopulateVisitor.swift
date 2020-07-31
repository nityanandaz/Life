//
//  PopulateVisitor.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

final class PopulateVisitor {
    var replacementDenizen: CellProtocol
    
    init(replacementDenizen: CellProtocol) {
        self.replacementDenizen = replacementDenizen
    }
}

extension PopulateVisitor: GridVisitor {
    func visitDenizen(_ denizen: CellProtocol?,
                      onGrid grid: Grid,
                      ofDimension n: Int,
                      atX x: Int,
                      y: Int) -> CellProtocol? {
        return replacementDenizen
    }
}
