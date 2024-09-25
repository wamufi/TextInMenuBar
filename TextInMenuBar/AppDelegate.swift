//
//  AppDelegate.swift
//  TextInMenuBar
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusBar: StatusBar?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusBar = StatusBar()
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    
}
