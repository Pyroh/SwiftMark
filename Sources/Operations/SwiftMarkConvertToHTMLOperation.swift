//
//  SMarkConvertToHTMLOperation.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 20/12/15.
//  Copyright © 2015 Pierre TACCHI. All rights reserved.
//

import Foundation

/// A `SwiftMarkConvertToHTMLOperation`
public class SwiftMarkConvertToHTMLOperation: SwiftMarkOperation {
    public override init(text: String, options: SwiftMarkOptions = .Default) {
        super.init(text: text, options: options)
    }
    
    public override init(url: NSURL, options: SwiftMarkOptions = .Default, encoding: UInt = NSUTF8StringEncoding) {
        super.init(url: url, options: options, encoding: encoding)
    }
    
    override func convert(commonMarkString: String) throws -> String {
        return try commonMarkToHTML(commonMarkString, options: self.options)
    }
}
