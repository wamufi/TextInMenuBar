//
//  TextOnMenuBarApp.swift
//  TextOnMenuBar
//

import SwiftUI

@main
struct TextOnMenuBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
        Settings {
            SettingsView()
        }
        
//        MenuBarExtra("Set the Text") {
//            SettingsLink {
//                Text("Settings")
//            }
//        }
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
