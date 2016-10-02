//
//  SwiftMarkOption.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 19/12/15.
//  Copyright © 2015 Pierre TACCHI. All rights reserved.
//

/// These options are used by the *CommonMark* parser.
public struct SwiftMarkOptions: OptionSet {
    public let rawValue: Int32
    public init(rawValue: Int32) { self.rawValue = rawValue }
     /// Default options.
    public static let Default = SwiftMarkOptions(rawValue: 0)
     /// Include a data−sourcepos attribute on all block elements.
    public static let SourcePos = SwiftMarkOptions(rawValue: 1 << 1)
     /// Render softbreak elements as hard line breaks.
    public static let HardBreaks = SwiftMarkOptions(rawValue: 1 << 2)
     /// Suppress raw HTML and unsafe links (javascript:, vbscript:, file:,  and data:,  except for image/png, image/gif, image/jpeg, or image/webp mimetypes). Raw HTML is replaced by  a  placeholder  HTML  comment.  Unsafe links are replaced by empty strings.
    public static let Safe = SwiftMarkOptions(rawValue: 1 << 3)
     /// Normalize tree by consolidating adjacent text nodes.
    public static let Normalize = SwiftMarkOptions(rawValue: 1 << 8)
     /// Validate UTF−8 in the input before parsing, replacing illegal sequences with the replacement character U+FFFD.
    public static let ValidateUTF8 = SwiftMarkOptions(rawValue: 1 << 9)
     /// Convert straight quotes to curly, — to em dashes, – to en dashes.
    public static let Smart = SwiftMarkOptions(rawValue: 1 << 10)
}
