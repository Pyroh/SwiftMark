//
//  SMarkConvertToHTMLOperation.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 20/12/15.
//  Copyright © 2015 Pierre TACCHI. All rights reserved.
//

import Foundation

/// A `SwiftMarkToHTMLOperation` converts any valid *CommonMark* text to HTML. Use this class if you want to convert *CommonMark* text to HTML asynchronously.
///
/// The blocks you assign to process the fetched records are executed serially on an internal queue managed by the operation. Your blocks must be capable of executing on a background thread, so any tasks that require access to the main thread must be redirected accordingly.
open class SwiftMarkToHTMLOperation: SwiftMarkOperation {
    /**
     Returns on initialized `SwiftMarkToHTMLOperation` object ready to convert the given *CommonMark* text using given options.
     
     - parameter text:    The *CommonMark* text.
     - parameter options: The options passed to the parser.
     
     - returns: An initialized `SwiftMarkToHTMLOperation` object ready to execute.
     */
    public override init(text: String, options: SwiftMarkOptions = .Default) {
        super.init(text: text, options: options)
    }
    
    /**
     Returns on initialized `SwiftMarkToHTMLOperation` object ready to convert the given *CommonMark* text using given options. Once the conversion is complete the given block will be executed.
     
     - parameter text:                    The *CommonMark* text.
     - parameter options:                 The options passed to the parser.
     - parameter conversionCompleteBlock: The block to execute once de conversion is complete.
     
     - returns: An initialized `SwiftMarkToHTMLOperation` object ready to execute.
     */
    public convenience init(text: String, options: SwiftMarkOptions = .Default, conversionCompleteBlock: @escaping ConversionCompleteBlock) {
        self.init(text: text, options: options)
        self.conversionCompleteBlock = conversionCompleteBlock
    }
    
    /**
     Returns on initialized `SwiftMarkToHTMLOperation` object ready to convert the given *CommonMark* text using given options. Once the conversion is complete the given block will be executed. If an error occurs the given block will execute.
     
     - parameter text:                    The *CommonMark* text.
     - parameter options:                 The options passed to the parser.
     - parameter conversionCompleteBlock: The block to execute once de conversion is complete.
     - parameter failureBlock:            The block to execute if an error occurs.
     
     - returns: An initialized `SwiftMarkToHTMLOperation` object ready to execute.
     */
    public convenience init(text: String, options: SwiftMarkOptions = .Default, conversionCompleteBlock: @escaping ConversionCompleteBlock, failureBlock: @escaping FailureBlock) {
        self.init(text: text, options: options)
        self.conversionCompleteBlock = conversionCompleteBlock
        self.failureBlock = failureBlock
    }
    
    /**
     Returns on initialized `SwiftMarkToHTMLOperation` object ready to convert *CommonMark* text read for the given file URL using given options and reading text using given encoding.
     
     - parameter text:     The *CommonMark* text.
     - parameter options:  The options passed to the parser.
     - parameter encoding: The text file encoding
     
     - returns: An initialized `SwiftMarkToHTMLOperation` object ready to execute.
     */
    public override init(url: URL, options: SwiftMarkOptions = .Default, encoding: UInt = String.Encoding.utf8.rawValue) {
        super.init(url: url, options: options, encoding: encoding)
    }
    
    /**
     Returns on initialized `SwiftMarkToHTMLOperation` object ready to convert *CommonMark* text read for the given file URL using given options and reading text using given encoding. Once the conversion is complete the given block will be executed.
     
     - parameter text:                    The *CommonMark* text.
     - parameter options:                 The options passed to the parser.
     - parameter encoding:                The text file encoding
     - parameter conversionCompleteBlock: The block to execute once de conversion is complete.
     
     - returns: An initialized `SwiftMarkToHTMLOperation` object ready to execute.
     */
    public convenience init(url: URL, options: SwiftMarkOptions = .Default, encoding: UInt = String.Encoding.utf8.rawValue, conversionCompleteBlock: @escaping ConversionCompleteBlock) {
        self.init(url: url, options: options)
        self.conversionCompleteBlock = conversionCompleteBlock
    }
    
    /**
     Returns on initialized `SwiftMarkToHTMLOperation` object ready to convert *CommonMark* text read for the given file URL using given options and reading text using given encoding. Once the conversion is complete the given block will be executed. If an error occurs the given block will execute.
     
     - parameter text:                    The *CommonMark* text.
     - parameter options:                 The options passed to the parser.
     - parameter encoding:                The text file encoding
     - parameter conversionCompleteBlock: The block to execute once de conversion is complete.
     - parameter failureBlock:            The block to execute if an error occurs.
     
     - returns: An initialized `SwiftMarkToHTMLOperation` object ready to execute.
     */
    public convenience init(url: URL, options: SwiftMarkOptions = .Default, encoding: UInt = String.Encoding.utf8.rawValue, conversionCompleteBlock: @escaping ConversionCompleteBlock, failureBlock: @escaping FailureBlock) {
        self.init(url: url, options: options)
        self.conversionCompleteBlock = conversionCompleteBlock
        self.failureBlock = failureBlock
    }
    
    override func convert(_ commonMarkString: String) throws -> String {
        return try commonMarkToHTML(commonMarkString, options: self.options)
    }
}
