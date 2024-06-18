//
//  TextInputWindowController.swift
//  TextOnMenuBar
//

import AppKit

class TextInputWindowController: NSWindowController {
    var textField = NSTextField()
    var onSave: ((String) -> Void)?
    
    convenience init() {
        self.init(window: NSWindow(contentRect: NSRect(x: 0, y: 0, width: 500, height: 200), styleMask: [.titled, .closable], backing: .buffered, defer: false))
//        self.init()
        self.window?.center()
        self.window?.title = "Please input here"
        setupLayout()
    }
    
    func show() {
        NSApp.activate()
        self.window?.makeKeyAndOrderFront(nil)
    }
    
    private func setupLayout() {
        let label = NSLabel()
        label.stringValue = "Please input text:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholderString = ""
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let okButton = NSButton(title: "OK", target: self, action: #selector(okAction))
        okButton.keyEquivalent = "\r"
        okButton.translatesAutoresizingMaskIntoConstraints = false
        
        let cancelButton = NSButton(title: "Cancel", target: self, action: #selector(cancelAction))
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        window?.contentView?.addSubview(label)
        window?.contentView?.addSubview(textField)
        window?.contentView?.addSubview(okButton)
        window?.contentView?.addSubview(cancelButton)
        
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

        window?.contentView?.addConstraints(constraints)
    }
    
    @objc private func okAction(sender: NSButton) {
        let text = textField.stringValue
        if !text.isEmpty {
            UserDefaults.standard.set(text, forKey: "setText")
            onSave?(text)
        }
        
        window?.close()
    }
    
    @objc private func cancelAction(sender: NSButton) {
        window?.close()
    }
}
