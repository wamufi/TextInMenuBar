//
//  SettingsViewController.swift
//  TextOnMenuBar
//

import AppKit

class SettingsViewController: NSViewController {
    var textField = NSTextField()
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
        
        let cancelButton = NSButton(title: "Cancel", target: self, action: #selector(cancelAction))
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(okButton)
        view.addSubview(cancelButton)
        
        let views = ["textField": textField, "ok": okButton, "cancel": cancelButton, "label": label]
        let format1 = "H:|-18-[textField]-18-|"
        let format2 = "H:[cancel]-16-[ok]-18-|"
        let format3 = "V:|-18-[label]-16-[textField]-16-[cancel]-18-|"
        let format4 = "V:|-18-[label]-16-[textField]-16-[ok]-18-|"
        let format5 = "H:|-18-[label]-18-|"
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: format1, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: format2, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: format3, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: format4, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: format5, metrics: nil, views: views)

        okButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 70).isActive = true

        view.addConstraints(constraints)
    }
    
    @objc private func okAction(sender: NSButton) {
        let text = textField.stringValue
        if !text.isEmpty {
            UserDefaults.standard.set(text, forKey: "setText")
            onSave?(text)
        }
    }
    
    @objc private func cancelAction(sender: NSButton) {
//        window?.close()
    }
}
