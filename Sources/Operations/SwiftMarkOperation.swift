//
//  SwiftMarkOperation.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 13/01/16.
//  Copyright © 2016 Pierre TACCHI. All rights reserved.
//

import Foundation

public typealias ConversionCompletionBlock = (String) -> ()
public typealias FailureBlock = (SwiftMarkError) -> ()

public class SwiftMarkOperation: NSOperation {
    private let markdownText: String?
    private let fileURL: NSURL?
    private let encoding: UInt
    
    internal let options: SwiftMarkOptions
    
    public var conversionCompleteBlock: ConversionCompletionBlock?
    public var failureBlock: FailureBlock?
    
    internal init(text: String, options: SwiftMarkOptions = .Default) {
        self.markdownText = text
        self.options = options
        self.encoding = 0
        self.fileURL = nil
    }
    
    internal init(url: NSURL, options: SwiftMarkOptions = .Default, encoding: UInt = NSUTF8StringEncoding) {
        self.markdownText = nil
        self.options = options
        self.encoding = encoding
        self.fileURL = url
    }
    
    override public func main() {
        guard !cancelled else { return }
        guard let commonMarkString = try? commonMarkString() else {
            dispatch_sync(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
                self.failureBlock?(SwiftMarkError.FileLoadingError)
            }
            return
        }
        guard !cancelled else { return }
        guard let convertedString = try? convert(commonMarkString) else {
            dispatch_sync(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
                self.failureBlock?(SwiftMarkError.ParsingError)
            }
            return
        }
        dispatch_sync(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { 
            self.conversionCompleteBlock?(convertedString)
        }
    }
    
    internal func convert(commonMarkString: String) throws -> String {
        throw SwiftMarkError.ParsingError
    }
    
    private func commonMarkString() throws -> String {
        if let commonMarkString = markdownText {
            return commonMarkString
        }
        guard let url = fileURL else { throw SwiftMarkError.FileLoadingError }
        return try loadCommonMarkFromURL(url, encoding: self.encoding)
    }
}