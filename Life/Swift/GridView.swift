//
//  GridView.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Cocoa

class DrawingVisitor: NSObject, GridVisitor {
    var view: NSView
    
    init(view: NSView) {
        self.view = view
    }
    
    func visitDenizen(_ denizen: Any!,
                      onGrid grid: Any!,
                      ofDimension n: Int,
                      atX x: Int,
                      y: Int) -> Any! {
        let denizen = denizen as! Cell
        let (n, x, y) = (CGFloat(n), CGFloat(x), CGFloat(y))
        
        let beginningHorizontal = x / n
        let beginningVertical = y / n
        let horizontalExtent = 1.0 / n
        let verticalExtent = 1.0 / n
        
        let boundsSize = view.bounds.size
        let cellRect = CGRect(x: beginningHorizontal * boundsSize.width,
                              y: beginningVertical * boundsSize.height,
                              width: horizontalExtent * boundsSize.width,
                              height: verticalExtent * boundsSize.height)
        
        let path = NSBezierPath(rect: cellRect)
        NSColor(calibratedWhite: CGFloat(denizen.population()),
                alpha: 1.0).set()
        path.stroke()
        NSColor(calibratedWhite: 1.0 - CGFloat(denizen.population()),
                alpha: 1.0).set()
        path.fill()
        
        return denizen
    }
    
    
}

class GridView: NSView {

    var currentGrid: Grid!
    var lifeController: LifeController!
    
    @objc
    func drawGrid(_ grid: Grid) -> Self {
        currentGrid = grid
        needsDisplay = true
        return self
    }
    
    override func draw(_ dirtyRect: NSRect) {
        currentGrid?.visit(DrawingVisitor(view: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        let location = convert(event.locationInWindow, to: nil)
        let boundsSize = bounds.size
        let fractionX = location.x / boundsSize.width
        let fractionY = location.y / boundsSize.height
        _ = lifeController.changeCellAtRelativeX(Float(fractionX),
                                                 y: Float(fractionY))
    }
}
