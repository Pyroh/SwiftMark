//
//  WindowController.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 15/01/16.
//  Copyright © 2016 Pierre TACCHI. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.titlebarAppearsTransparent = true
        window?.backgroundColor = NSColor.white
        windowFrameAutosaveName = "SwiftMarkMainWindow" // Doesn't work using Xcode's "autosave name" property.
    }
}
