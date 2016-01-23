//
//  SwiftMark.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 04/12/15.
//  Copyright © 2015 Pierre TACCHI. All rights reserved.
//

import Foundation
import libcmark

/**
 Produce the HTML string corresponding to the given CommonMark string.  
 Using default options `SwiftMarkOptions.Default`
 
 - throws: `SwiftMark.ParsingError` if something goes wrong.
 */
public func commonMarkToHTML(str: String, options: SwiftMarkOptions = .Default) throws -> String {
    var buffer: String?
    str.withCString {
        let buf = cmark_markdown_to_html($0, Int(strlen($0)), options.rawValue)
        buffer = String(CString: buf, encoding: NSUTF8StringEncoding)
        free(buf)
    }
    guard let output = buffer else { throw SwiftMarkError.ParsingError }
    return output
}

/**
 Produce the LATEX string corresponding to the given CommonMark string.
 Using default options `SwiftMarkOptions.Default`
 
 - throws: `SwiftMark.ParsingError` if something goes wrong.
 */
public func commonMarkToLATEX(str: String, width: Int32 = 0, options: SwiftMarkOptions = .Default) throws -> String {
    guard let ast = commonMarkAST(str, options: options) else { throw SwiftMarkError.ParsingError }
    let buf = cmark_render_latex(ast, options.rawValue, width)
    let buffer = String(CString: buf, encoding: NSUTF8StringEncoding)
    cmark_node_free(ast)
    free(buf);
    guard let output = buffer else { throw SwiftMarkError.ParsingError }
    return output
}

/**
 Produce the XML string corresponding to the given CommonMark string.
 Using default options `SwiftMarkOptions.Default`
 
 - throws: `SwiftMark.ParsingError` if something goes wrong.
 */
public func commonMarkToXML(str: String, options: SwiftMarkOptions = .Default) throws -> String {
    guard let ast = commonMarkAST(str, options: options) else { throw SwiftMarkError.ParsingError }
    let buf = cmark_render_xml(ast, options.rawValue)
    let buffer = String(CString: buf, encoding: NSUTF8StringEncoding)
    cmark_node_free(ast)
    free(buf);
    ast.destroy()
    buf.destroy()
    guard let output = buffer else { throw SwiftMarkError.ParsingError }
    return output
}

 /**
 Tokenize the given CommonMark string.
 Using default options `SwiftMarkOptions.Default`
 */
internal func commonMarkAST(str: String, options: SwiftMarkOptions = .Default) -> UnsafeMutablePointer<cmark_node>? {
    var ast: UnsafeMutablePointer<cmark_node>?
    str.withCString {
        ast = cmark_parse_document($0, Int(strlen($0)), options.rawValue)
    }
    return ast
}

/**
 Load CommonMark from `url` using the specified encoding.
 
 - throws: `SwiftMarkError.FileLoadingError` if something goes wrong during file access.
 */
internal func loadCommonMarkFromURL(url: NSURL, encoding: UInt = NSUnicodeStringEncoding) throws -> String {
    guard let data = NSData(contentsOfURL: url), str = String(data: data, encoding: encoding) else {
        throw SwiftMarkError.FileLoadingError
    }
    return str
}
