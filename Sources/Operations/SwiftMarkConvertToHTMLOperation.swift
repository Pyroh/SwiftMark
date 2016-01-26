//
//  SMarkConvertToHTMLOperation.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 20/12/15.
//  Copyright © 2015 Pierre TACCHI. All rights reserved.
//

import Foundation

/// A `SwiftMarkConvertToHTMLOperation`
public class SwiftMarkToHTMLOperation: SwiftMarkOperation {
    public override init(text: String, options: SwiftMarkOptions = .Default) {
        super.init(text: text, options: options)
    }
    
    public convenience init(text: String, options: SwiftMarkOptions = .Default, conversionCompleteBlock: ConversionCompleteBlock) {
        self.init(text: text, options: options)
        self.conversionCompleteBlock = conversionCompleteBlock
    }
    
    public convenience init(text: String, options: SwiftMarkOptions = .Default, conversionCompleteBlock: ConversionCompleteBlock, failureBlock: FailureBlock) {
        self.init(text: text, options: options)
        self.conversionCompleteBlock = conversionCompleteBlock
        self.failureBlock = failureBlock
    }
    
    public override init(url: NSURL, options: SwiftMarkOptions = .Default, encoding: UInt = NSUTF8StringEncoding) {
        super.init(url: url, options: options, encoding: encoding)
    }
    
    public convenience init(url: NSURL, options: SwiftMarkOptions = .Default, encoding: UInt = NSUTF8StringEncoding, conversionCompleteBlock: ConversionCompleteBlock) {
        self.init(url: url, options: options)
        self.conversionCompleteBlock = conversionCompleteBlock
    }
    
    public convenience init(url: NSURL, options: SwiftMarkOptions = .Default, encoding: UInt = NSUTF8StringEncoding, conversionCompleteBlock: ConversionCompleteBlock, failureBlock: FailureBlock) {
        self.init(url: url, options: options)
        self.conversionCompleteBlock = conversionCompleteBlock
        self.failureBlock = failureBlock
    }
    
    override func convert(commonMarkString: String) throws -> String {
        return try commonMarkToHTML(commonMarkString, options: self.options)
    }
}
