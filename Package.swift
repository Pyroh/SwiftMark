//
//  Package.swift
//  CoreGeometry
//
//  Created by Pierre TACCHI on 20/04/16.
//  Copyright © 2016 Pyrolyse. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "SwiftMark",
    targets: [ Target(name: "SwiftMark", dependencies: ["libcmark"])],
    exclude: ["SwiftMark.xworkspace", "README.md", "LICENCE", "Xcode", "Documentation", "Sources/Classes"]
)
