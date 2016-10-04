//
//  ViewController.swift
//  ExampleOSX
//
//  Created by Pierre TACCHI on 15/01/16.
//  Copyright © 2016 Pierre TACCHI. All rights reserved.
//

import Cocoa
import SwiftMark

class ViewController: NSViewController, NSTextViewDelegate, NSTextDelegate {
    @IBOutlet var attributedTextView: NSTextView!
    @IBOutlet var inputTextView: NSTextView!
    @IBOutlet weak var cssFileNameLabel: NSTextField!
    @IBOutlet weak var clearCSSButton: NSButton!
    
    internal dynamic var async: Bool = true {
        didSet {
            requestCommonMarkConversion()
        }
    }
    
    private let queue = OperationQueue()
    private var cssString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextView.font = NSFont(name: "Menlo", size: 13.0)
    }

    func textDidChange(_ notification: Notification) {
        queue.cancelAllOperations()
        requestCommonMarkConversion()
    }
    
    private func requestCommonMarkConversion() {
        guard let md = inputTextView.string else { return }
        if async {
            let op = SwiftMarkToHTMLOperation(text: md)
            op.conversionCompleteBlock = { html in
                DispatchQueue.main.sync { [unowned self] in
                    self.attributedTextView.textStorage?.setAttributedString(NSAttributedString.attributedStringFromHTML(html, withCSSString: self.cssString))
                }
            }
            op.failureBlock = { _ in
                self.attributedTextView.string = "!! ERROR !!"
            }
            queue.addOperation(op)
            
        } else {
            if let html = try? commonMarkToHTML(md) {
                self.attributedTextView.textStorage?.setAttributedString(NSAttributedString.attributedStringFromHTML(html, withCSSString: self.cssString))
            }
        }
    }
    
    @IBAction func loadCSS(_ sender: AnyObject) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        openPanel.allowsMultipleSelection = false
        openPanel.allowedFileTypes = ["css"]
        
        if openPanel.runModal() == NSModalResponseOK, let url = openPanel.url, let data = try? Data(contentsOf: url) {
            let filename = url.lastPathComponent
            self.cssString = String(data: data, encoding: String.Encoding.utf8)
            cssFileNameLabel.stringValue = filename
            cssFileNameLabel.isHidden = false
            clearCSSButton.isHidden = false
            
            requestCommonMarkConversion()
        }
    }
    
    @IBAction func clearCSS(_ sender: AnyObject) {
        cssString = nil
        cssFileNameLabel.isHidden = true
        clearCSSButton.isHidden = true
        
        requestCommonMarkConversion()
    }
}

