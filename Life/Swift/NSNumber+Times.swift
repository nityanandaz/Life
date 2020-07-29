//
//  NSNumber+Times.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

@objc
extension NSNumber {
    func times(_ target: Any!, perform action: Selector!) -> Any! {
        return times(target, perform: action, withObject: nil)
    }
    
    func times(_ target: Any!, perform action: Selector!, withObject object: Any!) -> Any! {
        return nonZero()?.realTimes(target, perform: action, with: object)
    }
}

private extension NSNumber {
    func realTimes(_ target: Any!, perform action: Selector!, with object: Any!) -> Any! {
        (target as? NSObject)?.perform(action, with: object)
        return NSNumber(integerLiteral: intValue - 1)
            .times(target, perform: action, withObject: object)
    }
    
    func nonZero() -> NSNumber? {
        intValue != 0
            ? self
            : nil
    }
}
