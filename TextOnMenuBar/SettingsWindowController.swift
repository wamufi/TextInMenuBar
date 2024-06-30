//
//  SettingsWindowController.swift
//  TextOnMenuBar
//

import AppKit
import ServiceManagement

class SettingsWindowController: NSWindowController {
    
    private var launchAtLogin: Bool = SMAppService.mainApp.status == .enabled
    
    convenience init() {
        self.init(window: NSWindow(contentRect: NSRect(x: 0, y: 0, width: 300, height: 100), styleMask: [.titled, .closable], backing: .buffered, defer: false))
//        self.init()
//        self.window?.styleMask = [.titled, .closable]
//        self.window?.backingType = .buffered
        self.window?.center()
        self.window?.title = "Settings"
        setupLayout()
        
        window?.delegate = self
    }
    
    func show() {
        NSApp.activate()
        self.window?.makeKeyAndOrderFront(nil)

        NSApp.setActivationPolicy(.regular)
    }
    
    private func setupLayout() {
        guard let view = window?.contentView else { return }
        
        let dockIconCheckbox = NSButton(checkboxWithTitle: "Hide the Dock Icon", target: self, action: #selector(dockIconCheckboxTapped(sender:)))
        dockIconCheckbox.translatesAutoresizingMaskIntoConstraints = false
        
        let launchCheckbox = NSButton(checkboxWithTitle: "Launch at Login", target: self, action: #selector(launchCheckboxTapped(sender:)))
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
        
        let isHiddenDockIcon = UserDefaults.standard.bool(forKey: "hideDockIcon")
        (isHiddenDockIcon == true) ? (dockIconCheckbox.state = .on) : (dockIconCheckbox.state = .off)
        
        (launchAtLogin == true) ? (launchCheckbox.state = .on) : (launchCheckbox.state = .off)
    }
    
    @IBAction func dockIconCheckboxTapped(sender: NSButton) {
        UserDefaults.standard.set(sender.state, forKey: "hideDockIcon")
    }
    
    @IBAction func launchCheckboxTapped(sender: NSButton) {
        do {
            if sender.state == .on {
                try SMAppService.mainApp.register()
            } else {
                try SMAppService.mainApp.unregister()
            }
        } catch {
            logError(items: error.localizedDescription)
        }
        
        launchAtLogin = SMAppService.mainApp.status == .enabled
    }
}

extension SettingsWindowController: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        let state = UserDefaults.standard.bool(forKey: "hideDockIcon")
        if state {
            NSApp.setActivationPolicy(.accessory)
        }
    }
}
