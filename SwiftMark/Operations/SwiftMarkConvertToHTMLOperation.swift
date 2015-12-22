//
//  SMarkConvertToHTMLOperation.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 20/12/15.
//  Copyright © 2015 Pierre TACCHI. All rights reserved.
//

import Cocoa

/// A `SwiftMarkConvertToHTMLOperation`
public class SwiftMarkConvertToHTMLOperation: NSOperation {
    public var markdownText: String
    public var options: SwiftMarkOptions
    public var conversionBlock: ConversionCompletionBlock?
    public var failureBlock: FailureBlock?
    
    public init(text: String, options: SwiftMarkOptions = .Default) {
        self.markdownText = text
        self.options = options
    }
    
    public convenience init(url: NSURL, options: SwiftMarkOptions = .Default) {
        if let data = NSData(contentsOfURL: url), let text = String(data: data, encoding: NSUnicodeStringEncoding) {
            self.init(text: text, options: options)
        } else {
            self.init(text: "", options: options)
        }
    }
    
    override public func main() {
        guard !cancelled else { return }
        let htmlString = markdownToHTML(markdownText, options: options)
        guard !cancelled else { return }
        guard let html = htmlString else {
            failureBlock?()
            return
        }
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [unowned self] in
            self.conversionBlock?(html)
        }
    }
}
