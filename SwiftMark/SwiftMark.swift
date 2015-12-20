//
//  SwiftMark.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 04/12/15.
//  Copyright © 2015 Pierre TACCHI. All rights reserved.
//

import Foundation
import libcmark

public typealias ConvertionCompletionBlock = (String) -> ()
public typealias FailureBlock = () -> ()

/**
 Convert `str` to HTML, with `options` passed to the parser.
 */
public func markdownToHTML(str: String, options: SwiftMarkOptions) -> String? {
    var output: String?
    str.withCString {
        let buf = cmark_markdown_to_html($0, Int(strlen($0)), options.rawValue)
        output = String(CString: buf, encoding: NSUTF8StringEncoding)
        free(buf)
    }
    return output
}
