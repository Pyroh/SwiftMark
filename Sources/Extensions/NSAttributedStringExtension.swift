//
//  NSAttributedStringExtension.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 15/01/16.
//  Copyright © 2016 Pierre TACCHI. All rights reserved.
//

import Cocoa

public extension NSAttributedString {
    public class func attributedStringFromHTML(html: String, withCSSString css: String?) -> NSAttributedString {
        var head = "<head>\n"
        head += "<meta charset=\"utf-8\">\n"
        if let css = css {
            head += "<style>\n" + css + "</style>\n"
        }
        head += "</head>\n"
        let doc = "<html>\n\(head)<body>\n\(html)\n</body>\n<html>"
        guard let data = doc.dataUsingEncoding(NSUnicodeStringEncoding) else { return NSAttributedString() }
        return NSAttributedString(HTML: data, baseURL: NSURL(), documentAttributes: nil) ?? NSAttributedString()
    }
}