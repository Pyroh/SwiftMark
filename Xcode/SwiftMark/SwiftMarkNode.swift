//
//  SwiftMarkNode.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 20/05/16.
//  Copyright © 2016 Pierre TACCHI. All rights reserved.
//

import Foundation

public enum ListType: Int {
    case None, Bullet, Ordered
}

public indirect enum Node {
    case None
    
    case // Blocks
    Document(children: [Node]),
    BlockQuote(children: [Node]),
    List(children: [Node]),
    Item(children: [Node]),
    CodeBlock(children: [Node], content: String),
    HtmlBlock(children: [Node], content: String),
    CustomBlock(children: [Node]),
    Paragraph(children: [Node]),
    Heading(children: [Node], level: Int),
    ThematicBreak(children: [Node])
    
    case // Inline
    Text(children: [Node], content: String),
    Softbreak(children: [Node]),
    Linebreak(children: [Node]),
    Code(children: [Node], content: String),
    Html(children: [Node], content: String),
    Custom(children: [Node]),
    Emphasis(children: [Node]),
    Strong(children: [Node]),
    Link(children: [Node]),
    Image(children: [Node])
}