//
//  StatusBar.swift
//  TextOnMenuBar
//

import AppKit
import SwiftUI

class StatusBar: NSObject {
    private var bar: NSStatusBar
    private var statusItem: NSStatusItem
    private var menu: NSMenu
    private var textInputWindowController: TextInputWindowController?
    
    override init() {
        bar = NSStatusBar.system
        statusItem = bar.statusItem(withLength: NSStatusItem.variableLength)
        menu = NSMenu(title: "Settings")

        super.init()
        
        addMenuItems()
        
        loadText()
    }
    
    private func loadText() {
        let text = UserDefaults.standard.string(forKey: "setText") ?? "Hello, World!"
        updateStatusItem(text: text)
    }
    
    private func updateStatusItem(text: String) {
        guard let button = statusItem.button else { return }
        button.title = text
    }
    
    private func addMenuItems() {
        let titleItem = NSMenuItem(title: "Set the Text", action: #selector(changeTextAction), keyEquivalent: "")
        titleItem.target = self
        
        let quitItem = NSMenuItem(title: "Quit", action: #selector(quitAction), keyEquivalent: "")
        quitItem.target = self
        
        menu.addItem(titleItem)
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
    
    @objc private func quitAction() {
        NSApplication.shared.terminate(self)
//        NSApp.terminate(self)
    }
}
