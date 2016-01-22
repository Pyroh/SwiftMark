//
//  SwiftMarkConvertToXMLOperation.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 21/12/15.
//  Copyright © 2015 Pierre TACCHI. All rights reserved.
//

import Foundation

public class SwiftMarkConvertToXMLOperation: SwiftMarkOperation {
    public override init(text: String, options: SwiftMarkOptions = .Default) {
        super.init(text: text, options: options)
    }
    
    public override init(url: NSURL, options: SwiftMarkOptions = .Default, encoding: UInt = NSUTF8StringEncoding) {
        super.init(url: url, options: options, encoding: encoding)
    }
    
    override func convert(commonMarkString: String) throws -> String {
        return try commonMarkToXML(commonMarkString, options: self.options)
    }
}

