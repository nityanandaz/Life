//
//  GridView.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Cocoa

public final class GridView: NSView {

    var currentGrid: Grid!
    public var lifeController: LifeController!
    
    func drawGrid(_ grid: Grid) -> GridView {
        currentGrid = grid
        needsDisplay = true
        return self
    }
    
    public override func draw(_ dirtyRect: NSRect) {
        _ = currentGrid?.visit(DrawingVisitor(view: self))
    }
    
    public override func mouseUp(with event: NSEvent) {
        let location = convert(event.locationInWindow, to: nil)
        let boundsSize = bounds.size
        let fractionX = location.x / boundsSize.width
        let fractionY = location.y / boundsSize.height
        _ = lifeController.changeCellAtRelative(x: fractionX,
                                                y: fractionY)
    }
}
