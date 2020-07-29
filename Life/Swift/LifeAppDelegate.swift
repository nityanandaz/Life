//
//  LifeAppDelegate.swift
//  Life
//
//  Created by Nityananda Zbil on 29.07.20.
//  Copyright © 2020 Nityananda Zbil. All rights reserved.
//

import Cocoa

class LifeAppDelegate: NSObject, NSApplicationDelegate {
    var lifeController: LifeController!
    var timer: Timer!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        lifeController = LifeController()
        let gridView = NSApplication.shared
            .mainWindow?
            .contentViewController?
            .view as? GridView
        
        gridView?.lifeController = lifeController
        lifeController.gridView = gridView
        lifeController.awakeFromNib()
    }
}

extension LifeAppDelegate {
    @IBAction func tick(_ sender: Any) {
        lifeController.tick(sender)
    }
    
    @IBAction func runTimer(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: lifeController!,
                                     selector: #selector(tick(_:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @IBAction func stopTimer(_ sender: Any) {
        timer?.invalidate()
        timer = nil
    }
}

@objc
extension LifeAppDelegate {
    func validate(menuItem: NSMenuItem) -> Bool {
        let action = NSStringFromSelector(menuItem.action!)
        let validateSelector = NSSelectorFromString("validate" + action)
        return (self.perform(validateSelector, with: menuItem) as! Bool?)!
    }
    
    func validaterunTimer(_ menuItem: Any) -> Bool {
        timer == nil
    }
    
    func validatestopTimer(_ menuItem: Any) -> Bool {
        timer != nil
    }
    
    func validatetick(_ menuItem: Any) -> Bool {
        timer == nil
    }
    
    func validatequit(_ menuItem: Any) -> Bool {
        true
    }
}
