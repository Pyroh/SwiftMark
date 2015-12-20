//: Playground - noun: a place where people can play

import Cocoa
import SwiftMarkOSX

let url = NSURL(fileURLWithPath: "/Users/Pyroh/Downloads/swift-framework-c-library-example-master/README.md")
let str = "#Hello\nList:\n- one\n- two"
let ptr = markdownToHTML(str, options: .Default)
func truc () {
    
}
