//
//  StatusBar.swift
//  TextOnMenuBar
//

import AppKit

class StatusBar: NSObject {
    
    private var statusItem: NSStatusItem
    private var menu: NSMenu
    private var popover: NSPopover!
    
    private var textInputWindowController: TextInputWindowController?
    private var settingsWindowController: SettingsWindowController?
    
    override init() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        menu = NSMenu(title: "Settings")

        super.init()
        
//        addMenuItems()
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
    
    private func addMenuItems() {
        let titleItem = NSMenuItem(title: "Set the Text", action: #selector(changeTextAction), keyEquivalent: "")
        titleItem.target = self
        
        let settingsItem = NSMenuItem(title: "Settings", action: #selector(showSettings), keyEquivalent: "")
        settingsItem.target = self
        
        let quitItem = NSMenuItem(title: "Quit", action: #selector(quitAction), keyEquivalent: "")
        quitItem.target = self
        
        menu.addItem(titleItem)
        menu.addItem(settingsItem)
        menu.addItem(.separator())
        menu.addItem(quitItem)
        
        statusItem.menu = menu
    }
    
    @objc private func changeTextAction() {
        if textInputWindowController == nil {
            textInputWindowController = TextInputWindowController()
            textInputWindowController?.onSave = { [weak self] text in
                self?.updateStatusItem(text: text)
            }
        }
        
        textInputWindowController?.show()
    }
    
    @objc private func showSettings() {
        if settingsWindowController == nil {
            settingsWindowController = SettingsWindowController()
        }
        
        settingsWindowController?.show()
    }
    
    @objc private func quitAction() {
        NSApplication.shared.terminate(self)
//        NSApp.terminate(self)
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
