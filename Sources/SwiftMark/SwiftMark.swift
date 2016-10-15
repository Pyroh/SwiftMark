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
 Produce the HTML string corresponding to the given CommonMark text using given options.
 
 - parameter str:     The *CommonMark* string to convert.
 - parameter options: The options passed to the parser.
 
 - throws: `SwiftMark.ParsingError` if something goes wrong.
 
 - returns: The HTML string produced by the *CommonMark* parser.
 */
public func commonMarkToHTML(_ str: String, options: SwiftMarkOptions = .Default) throws -> String {
    var buffer: String?
    try str.withCString {
        guard let buf = cmark_markdown_to_html($0, Int(strlen($0)), options.rawValue) else { throw SwiftMarkError.parsingError }
        
        buffer = String(validatingUTF8: buf)
        free(buf)
    }
    guard let output = buffer else { throw SwiftMarkError.parsingError }
    return output
}

/**
 Produce the XML string corresponding to the given CommonMark text using given options.
 
 - parameter str:     The *CommonMark* string to convert.
 - parameter options: The options passed to the parser.
 
 - throws: `SwiftMark.ParsingError` if something goes wrong.
 
 - returns: The XML string produced by the *CommonMark* parser.
 */
public func commonMarkToXML(_ str: String, options: SwiftMarkOptions = .Default) throws -> String {
    guard let ast = commonMarkAST(str, options: options) else { throw SwiftMarkError.parsingError }
    defer { cmark_node_free(ast); ast.deinitialize() }
    guard let buf = cmark_render_xml(ast, options.rawValue) else { throw SwiftMarkError.parsingError }
    defer { free(buf); buf.deinitialize() }
    let buffer = String(validatingUTF8: buf)
    guard let output = buffer else { throw SwiftMarkError.parsingError }
    return output
}

private func commonMarkToLATEX(_ str: String, width: Int32 = 0, options: SwiftMarkOptions = .Default) throws -> String {
    guard let ast = commonMarkAST(str, options: options) else { throw SwiftMarkError.parsingError }
    defer { cmark_node_free(ast) }
    guard let buf = cmark_render_latex(ast, options.rawValue, width) else { throw SwiftMarkError.parsingError }
    defer { free(buf) }
    let buffer = String(validatingUTF8: buf)
    guard let output = buffer else { throw SwiftMarkError.parsingError }
    return output
}

 /**
 Tokenize the given *CommonMark* string using given options.
 */
internal func commonMarkAST(_ str: String, options: SwiftMarkOptions = .Default) -> UnsafeMutablePointer<cmark_node>? {
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
internal func loadCommonMarkFromURL(_ url: URL, encoding: String.Encoding = String.Encoding.unicode) throws -> String {
    guard let data = try? Data(contentsOf: url), let str = String(data: data, encoding: encoding) else {
        throw SwiftMarkError.fileLoadingError
    }
    return str
}
