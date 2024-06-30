//
//  TextOnMenuBarApp.swift
//  TextOnMenuBar
//

import SwiftUI

@main
struct TextOnMenuBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            SettingsView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
//    private var statusItem: NSStatusItem!
    private var statusBar: StatusBar?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        logDebug(items: "finishLaunching: \(notification)")
//        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBar = StatusBar()
    }
}
