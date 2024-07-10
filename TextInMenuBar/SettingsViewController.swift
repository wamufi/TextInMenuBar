//
//  SettingsViewController.swift
//  TextInMenuBar
//

import AppKit
import ServiceManagement

class SettingsViewController: NSViewController {
    
    private var launchAtLogin: Bool = SMAppService.mainApp.status == .enabled
    
    private var textField = NSTextField()
    var onSave: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 400, height: 200))
    }
    
    private func setupLayout() {
        let label = NSLabel()
        label.stringValue = "Please input text:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholderString = UserDefaults.standard.string(forKey: "setText") ?? "Hello, World!"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let okButton = NSButton(title: "OK", target: self, action: #selector(okAction))
        okButton.keyEquivalent = "\r"
        okButton.translatesAutoresizingMaskIntoConstraints = false
        
        let launchCheckbox = NSButton(checkboxWithTitle: "Launch at Login", target: self, action: #selector(launchCheckboxTapped(sender:)))
        launchCheckbox.translatesAutoresizingMaskIntoConstraints = false
        
        let quitButton = NSButton(title: "Quit", target: self, action: #selector(quitAction))
        quitButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(okButton)
        view.addSubview(launchCheckbox)
        view.addSubview(quitButton)
        
        let views = ["textField": textField, "ok": okButton, "label": label, "launch": launchCheckbox, "quit": quitButton]
        let format0 = "H:|-18-[label]-18-|"
        let format1 = "H:|-18-[textField]-16-[ok]-18-|"
        let format2 = "H:|-18-[launch]-16-[quit]-18-|"
        let format3 = "V:|-18-[label]-12-[ok]-18-[launch]-18-|"
        let format4 = "V:|-18-[label]-12-[textField]-18-[launch]-18-|"
        let format5 = "V:|-18-[label]-12-[textField]-18-[quit]-18-|"
        
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: format0, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: format1, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: format2, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: format3, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: format4, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: format5, metrics: nil, views: views)

        okButton.widthAnchor.constraint(equalToConstant: 70).isActive = true

        view.addConstraints(constraints)
    }
    
    @objc private func okAction(sender: NSButton) {
        let text = textField.stringValue
        if !text.isEmpty {
            UserDefaults.standard.set(text, forKey: "setText")
            onSave?(text)
        }
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
    
    @objc private func quitAction(sender: NSButton) {
        NSApplication.shared.terminate(self)
    }
}
