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
    
    private let queue = NSOperationQueue()
    private var cssString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextView.font = NSFont(name: "Menlo", size: 13.0)
    }

    func textDidChange(notification: NSNotification) {
        queue.cancelAllOperations()
        requestCommonMarkConversion()
    }
    
    private func requestCommonMarkConversion() {
        guard let md = inputTextView.string else { return }
        if async {
            let op = SwiftMarkToHTMLOperation(text: md)
            op.conversionCompleteBlock = { html in
                dispatch_sync(dispatch_get_main_queue()) { [unowned self] in
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
    
    @IBAction func loadCSS(sender: AnyObject) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        openPanel.allowsMultipleSelection = false
        openPanel.allowedFileTypes = ["css"]
        
        if openPanel.runModal() == NSModalResponseOK, let url = openPanel.URL, filename = url.lastPathComponent, data = NSData(contentsOfURL: url) {
            self.cssString = String(data: data, encoding: NSUTF8StringEncoding)
            cssFileNameLabel.stringValue = filename
            cssFileNameLabel.hidden = false
            clearCSSButton.hidden = false
            
            requestCommonMarkConversion()
        }
    }
    
    @IBAction func clearCSS(sender: AnyObject) {
        cssString = nil
        cssFileNameLabel.hidden = true
        clearCSSButton.hidden = true
        
        requestCommonMarkConversion()
    }
}

