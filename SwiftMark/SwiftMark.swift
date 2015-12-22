//
//  SwiftMark.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 04/12/15.
//  Copyright © 2015 Pierre TACCHI. All rights reserved.
//

import Foundation
import libcmark

public typealias ConversionCompletionBlock = (String) -> ()
public typealias FailureBlock = () -> ()

/**
 Convert `str` to HTML, with `options` passed to the parser.
 */
public func markdownToHTML(str: String, options: SwiftMarkOptions = .Default) -> String? {
    var output: String?
    str.withCString {
        let buf = cmark_markdown_to_html($0, Int(strlen($0)), options.rawValue)
        output = String(CString: buf, encoding: NSUTF8StringEncoding)
        free(buf)
    }
    return output
}

/**
 Convert `str` to LATEX, with `options` passed to the parser.
 */
public func markdownToLATEX(str: String, width: Int32 = 0, options: SwiftMarkOptions = .Default) -> String? {
    guard let ast = markdownAST(str, options: options) else { return nil }
    let buf = cmark_render_latex(ast, options.rawValue, width)
    let output = String(CString: buf, encoding: NSUTF8StringEncoding)
    cmark_node_free(ast)
    free(buf);
    return output
}

/**
 Convert `str` to XML, with `options` passed to the parser.
 */
public func markdownToXML(str: String, options: SwiftMarkOptions = .Default) -> String? {
    guard let ast = markdownAST(str, options: options) else { return nil }
    let buf = cmark_render_xml(ast, options.rawValue)
    let output = String(CString: buf, encoding: NSUTF8StringEncoding)
    cmark_node_free(ast)
    free(buf);
    return output
}

internal func markdownAST(str: String, options: SwiftMarkOptions = .Default) -> UnsafeMutablePointer<cmark_node>? {
    var ast: UnsafeMutablePointer<cmark_node>?
    str.withCString {
        ast = cmark_parse_document($0, Int(strlen($0)), options.rawValue)
    }
    return ast
}

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
