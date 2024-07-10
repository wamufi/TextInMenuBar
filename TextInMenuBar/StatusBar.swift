//
//  StatusBar.swift
//  TextInMenuBar
//

import AppKit

class StatusBar: NSObject {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    override init() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        super.init()
        
        addPopover()
        loadText()
    }
    
    private func loadText() {
        let text = UserDefaults.standard.string(forKey: "setText") ?? "Hello, World!"
        updateStatusItem(text: text)
    }
    
    private func updateStatusItem(text: String) {
        guard let button = statusItem.button else { return }
        button.title = text
        button.target = self
        button.action = #selector(togglePopover)
    }
    
    private func addPopover() {
        let settingsViewController = SettingsViewController()
        settingsViewController.onSave = { [weak self] text in
            self?.updateStatusItem(text: text)
        }
        
        popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 200)
        popover.behavior = .transient
        popover.contentViewController = settingsViewController
    }
    
    @objc func togglePopover() {
        if let button = statusItem.button {
            if popover.isShown {
                popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
