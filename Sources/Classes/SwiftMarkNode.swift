//
//  SwiftMarkNode.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 21/12/15.
//  Copyright © 2015 Pierre TACCHI. All rights reserved.
//

public struct SwiftMarkNode {
    public let type: NodeType
    public var children = [SwiftMarkNode]()
    
    public init(type: NodeType) {
        self.type = type
    }
}
