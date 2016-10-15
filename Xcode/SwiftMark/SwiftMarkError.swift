//
//  SwiftMarkError.swift
//  SwiftMark
//
//  Created by Pierre TACCHI on 13/01/16.
//  Copyright © 2016 Pierre TACCHI. All rights reserved.
//

/**
Errors that can be thrown by **Swift***Mark*

- FileLoadingError: Indicates that the file cannot be read or loaded for any reason.
- ParsingError:     Indicates that the parser couldn't finish its work. Very unlikely to happen. I don't event know how to cause one...
*/
public enum SwiftMarkError: Error {
    case fileLoadingError
    case parsingError
}
