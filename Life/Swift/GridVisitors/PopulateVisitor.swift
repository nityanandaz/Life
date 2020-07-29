//
//  PopulateVisitor.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

class PopulateVisitor: NSObject {
    var replacementDenizen: Any!
    
    init(replacementDenizen: Any!) {
        self.replacementDenizen = replacementDenizen
    }
}

@objc
extension PopulateVisitor {
    static func populateWith(_ denizen: Any!) -> PopulateVisitor {
        return PopulateVisitor(replacementDenizen: denizen)
    }
}

extension PopulateVisitor: GridVisitor {
    func visitDenizen(_ denizen: Any!,
                      onGrid grid: Any!,
                      ofDimension n: Int,
                      atX x: Int,
                      y: Int) -> Any! {
        return replacementDenizen
    }
}
