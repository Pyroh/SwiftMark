[![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Platforms](https://img.shields.io/badge/platform-osx%20%7C%20ios-lightgrey.svg)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/license-MIT-71787A.svg)](https://tldrlegal.com/license/mit-license)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Dash compatible](https://img.shields.io/badge/Dash-compatible-593BB1.svg)](https://kapeli.com/dash)
![swiftmarklogo](https://cloud.githubusercontent.com/assets/5583681/12586335/269206cc-c450-11e5-81eb-ebf8407c2c01.png)

> **At this time there's no Swift 3 support. Since at least one thing may break with every new Xcode beta release I've decided to delay the Swift 3 support until GM release. You can fork the project and modify the code but I won't accept any pull request that tries to bring Swift 3's support.**

## Goals
**Swift***Mark* is not only a wrapper of the C library cmark but it also relies on it to provide users a complete Swift [*CommonMark*](http://commonmark.org) framework.  
This framework offers high-level API to convert any [*CommonMark*](http://commonmark.org) text to HTML, XML and soon LATEX.

## Requirements
- OS X 10.10+ / iOS 8.0+
- Xcode 7.2+

## Setup
### Using Carthage
Add `github "Pyroh/SwiftMark" ~> 0.9` to your `Cartfile` and run `carthage update`. If you need help using Carthage you can take a look at their [Getting Started](https://github.com/Carthage/Carthage#getting-started) section.

### Manually
1. Clone this repository.
2. Build the `SwiftMark` project.
3. Add the resulting `framework` file to your project.
4. ?
5. Profit.

## Synchronous vs. Asynchronous
With **Swift***Mark* you are able to convert [*CommonMark*](http://commonmark.org) text synchronously or asynchronously. 

### Synchronous method:

Simply use a conversion functions:

```Swift
let md = "**Swift***Mark*"
if let html = try? commonMarkToHTML(md){
	// html = "<p><b>Swift</b><em>Mark</em></p>"
	// do something with html…
}
```

### Asynchronous method

Asynchronous convert process rely on *Grand Central Dispatch* through `NSOperation` subclasses.  
You should instantiate one of this subclasses and manage result or failure in a closure:

```Swift
let md = "**Swift***Mark*"

let op = SwiftMarkToHTMLOperation(text: md)
op.conversionCompleteBlock = { html in
	// html = "<p><b>Swift</b><em>Mark</em></p>"
	// do something with html…
}
op.failureBlock = { error in
	// Handle the error.
}

// Provided that queue is an NSOperationQueue object.
queue.addOperation(op)

// If you don't want to use NSOperationQueue just
queue.start()
```

## Documentation
Full documentation is available [here](http://pyroh.github.io/docs/SwiftMark/index.html)

### Functions
**Swift***Mark* offers two global functions:
- `commonMarkToHTML(str: String, options: SwiftMarkOptions = .Default)`
- `commonMarkToXML(str: String, options: SwiftMarkOptions = .Default)`

These two functions produce HTML or XML code based on a given [*CommonMark*](http://commonmark.org) text. Each function can throw an error if there's been a problem during the parsing process.
(For available options please refer to full documentation)

### Operations
You can dispatch the conversion process on another thread if you prefer. **Swift***Mark* enables you to do so simply by using a subclass of `SwiftMarkOperation` which is a subclass of `NSOperation`. There's two of these subclasses available:

- `SwiftMarkToHTMLOperation` 
- `SwiftMarkToXMLOperation`

I think each class is self-explanatory.

In order to convert a *CommonMark* text you must :

1. Create a new SwiftMarkOperation object  
	`let op = SwiftMarkToHTMLOperation(text: md)`

2. Set the closure which will be executed once the conversion is done  
	`op.conversionCompleteBlock = { html in …}`

3. Optionally set the closure which will be called in case of failure  
	`op.failureBlock = { error in …}`

Now it's up to you: 
- You add your operation to an `NSOperationQueue`.
- You manually start your operation.

### Generate documentation
- Be sure [jazzy](https://github.com/Realm/jazzy) is installed.
- Go to `Documentation` folder.
- Run `sh gendoc.sh` or `chmod +x gendoc.sh && ./gendoc.sh`

## TODO
- [ ] LATEX support.
- [ ] iOS sample code.
- [ ] Give user access to document's AST… the Swift way… 
- [ ] Tests.
- [ ] CocoaPods support.

## License
**Swift***Mark* is released under the MIT license. See LICENSE for details.

The cmark library used to build **Swift***Mark* is Copyright (c) 2014, John MacFarlane. More information in [COPYING](https://raw.githubusercontent.com/Pyroh/SwiftMark/master/Sources/cmark/COPYING).


