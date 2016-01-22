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
 Convert `str` to HTML with `options` passed as argument to the parser.
 
 - returns: The corresponding HTML string or nil on error.
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
 Convert `str` to LATEX with `options` passed as argument to the parser.
 
 - returns: The corresponding LATEX string or nil on error.
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
 Convert `str` to XML with `options` passed as argument to the parser.
 
 - returns: The corresponding XML string or nil on error.
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
 Tokenize the CommonMark string `str`.
 
 - returns: The CommonMark node tree corresponding to `str` or nil on error.
 */
internal func commonMarkAST(str: String, options: SwiftMarkOptions = .Default) -> UnsafeMutablePointer<cmark_node>? {
    var ast: UnsafeMutablePointer<cmark_node>?
    str.withCString {
        ast = cmark_parse_document($0, Int(strlen($0)), options.rawValue)
    }
    return ast
}

internal func loadCommonMarkFromURL(url: NSURL, encoding: UInt = NSUnicodeStringEncoding) throws -> String {
    guard let data = NSData(contentsOfURL: url), str = String(data: data, encoding: encoding) else {
        throw SwiftMarkError.FileLoadingError
    }
    return str
}

/**
 Prints out CommonMark AST to stdout.
 For internal use only.
 */
internal func debugAST(ast: UnsafeMutablePointer<cmark_node>) {
    func printBuffer(ast: UnsafeMutablePointer<cmark_node>, depth: Int) {
        guard let type = NodeType(rawValue: Int(ast.memory.type.rawValue)) else { return }
        var buffer = ""
        0.stride(to: depth, by: 1).forEach {_ in
            buffer += "  "
        }
        
        print("\(buffer) \(type): (\(ast.memory.start_line):\(ast.memory.start_column)):(\(ast.memory.end_line):\(ast.memory.end_column))")
        
        if ast.memory.first_child != nil {
            printBuffer(ast.memory.first_child, depth: depth + 1)
        }
        if ast.memory.next != nil {
            printBuffer(ast.memory.next, depth: depth)
        }
    }
    printBuffer(ast, depth: 0)
    cmark_node_free(ast)
}
