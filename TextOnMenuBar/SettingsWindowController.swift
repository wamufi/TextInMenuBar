//
//  SettingsWindowController.swift
//  TextOnMenuBar
//

import AppKit

class SettingsWindowController: NSWindowController {
    convenience init() {
        self.init(window: NSWindow(contentRect: NSRect(x: 0, y: 0, width: 300, height: 100), styleMask: [.titled, .closable], backing: .buffered, defer: false))
//        self.init()
//        self.window?.styleMask = [.titled, .closable]
//        self.window?.backingType = .buffered
        self.window?.center()
        self.window?.title = "Settings"
        setupLayout()
    }
    
    func show() {
        NSApp.activate()
        self.window?.makeKeyAndOrderFront(nil)
    }
    
    private func setupLayout() {
        guard let view = window?.contentView else { return }
        
        let dockIconCheckbox = NSButton(checkboxWithTitle: "Hide the Dock Icon", target: self, action: #selector(dockIconCheckboxTapped(sender:)))
        dockIconCheckbox.translatesAutoresizingMaskIntoConstraints = false
        
        let launchCheckbox = NSButton(checkboxWithTitle: "Launch on Login", target: self, action: #selector(launchCheckboxTapped(sender:)))
        launchCheckbox.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(dockIconCheckbox)
        view.addSubview(launchCheckbox)
        
        dockIconCheckbox.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1.5).isActive = true
        dockIconCheckbox.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 1).isActive = true
        dockIconCheckbox.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1.5).isActive = true
        
        launchCheckbox.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1.5).isActive = true
        launchCheckbox.topAnchor.constraint(equalToSystemSpacingBelow: dockIconCheckbox.bottomAnchor, multiplier: 1.5).isActive = true
        launchCheckbox.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1.5).isActive = true
//        launchCheckbox.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 1).isActive = true
    }
    
    @IBAction func dockIconCheckboxTapped(sender: NSButton) {
        if sender.state == .on {
            NSApp.setActivationPolicy(.accessory)
        } else {
            NSApp.setActivationPolicy(.regular)
        }
    }
    
    @IBAction func launchCheckboxTapped(sender: NSButton) {
        if sender.state == .on {
            
        } else {
            
        }
    }
}
