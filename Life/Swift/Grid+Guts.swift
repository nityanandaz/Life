//
//  Grid+Guts.swift
//  Life
//
//  Created by Nityananda Zbil on 30.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Foundation

class Grid: NSObject {
    var n: Int!
    var array: [Any]!
    
    init(sideLength: Int) {
        super.init()
        _ = self._configureWithSideLength(sideLength)
    }
    
    init(sideLength: Int, dwellers: [Any]) {
        super.init()
        _ = self._configureWithSideLength(sideLength, dwellers: dwellers)
    }
    
    func indexFor(x: Int, y: Int) -> Int {
        let n: Int = self.n
        let index = ((x+n)%n)*n + ((y+n)%n)
        
        assert(index >= 0)
        assert(index < n*n)
        
        return index
    }
}

private extension Grid {
    func _configureWithSideLength(_ length: Int) -> Grid {
        assert(length > 0)
        
        let empty = EmptyCell()
        let dwellers = Array(repeating: empty,
                             count: length*length)
        
        return _configureWithSideLength(length, dwellers: dwellers)
    }
    
    func _configureWithSideLength(_ length: Int, dwellers: [Any]) -> Grid {
        assert(length > 0)
        assert(dwellers.count == length*length)
        
        self.n = length
        self.array = dwellers
        
        return self
    }
}
