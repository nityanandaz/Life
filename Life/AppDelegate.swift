//
//  AppDelegate.swift
//  Life
//
//  Created by Nityananda Zbil on 31.07.20.
//

import Cocoa
import LifeKit

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {
    var lifeController: LifeController!
    var timer: Timer!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        guard let gridView = NSApplication.shared
                .mainWindow?
                .contentViewController?
                .view as? GridView else {
            fatalError()
        }
        
        lifeController = LifeController(gridView: gridView)
        gridView.lifeController = lifeController
    }
}

extension AppDelegate {
    @IBAction func tick(_ sender: Any) {
        lifeController.tick(sender)
    }
    
    @IBAction func runTimer(_ sender: Any) {
        timer?.invalidate()
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
extension AppDelegate {
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
