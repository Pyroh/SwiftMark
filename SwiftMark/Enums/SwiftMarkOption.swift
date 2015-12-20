//
//  SwiftMarkOption.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 19/12/15.
//  Copyright © 2015 Pierre TACCHI. All rights reserved.
//

import Foundation

/**
 *  CommonMark parser options.
 */
public struct SwiftMarkOptions: OptionSetType {
    public let rawValue: Int32
    public init(rawValue: Int32) { self.rawValue = rawValue }
    public static let Default = SwiftMarkOptions(rawValue: 0)
    public static let SourcePos = SwiftMarkOptions(rawValue: 1)
    public static let HardBreaks = SwiftMarkOptions(rawValue: 2)
    public static let Normalize = SwiftMarkOptions(rawValue: 4)
    public static let Smart = SwiftMarkOptions(rawValue: 8)
    public static let ValidateUTF8 = SwiftMarkOptions(rawValue: 16)
    public static let Safe = SwiftMarkOptions(rawValue: 32)
}