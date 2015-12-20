//
//  SMarkConvertToHTMLOperation.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 20/12/15.
//  Copyright © 2015 Pierre TACCHI. All rights reserved.
//

import Cocoa

public class SMarkConvertToHTMLOperation: NSOperation {
    private var markdownText: String
    private var options: SwiftMarkOptions
    public var conversionBlock: ConvertionCompletionBlock?
    public var failureBlock: FailureBlock?
    
    public init(text: String, options: SwiftMarkOptions = .Default) {
        self.markdownText = text
        self.options = options
    }
    
    public convenience init?(url: NSURL, options: SwiftMarkOptions = .Default) {
        guard let data = NSData(contentsOfURL: url), let text = String(data: data, encoding: NSUnicodeStringEncoding) else
        { return nil }
        self.init(text: text, options: options)
    }
    
    override public func main() {
        guard !cancelled else { return }
        let htmlString = markdownToHTML(markdownText, options: options)
        guard !cancelled else { return }
        guard let html = htmlString else {
            failureBlock?()
            return
        }
        conversionBlock?(html)
    }
    
    func text() -> String {
        return markdownText
    }
}
