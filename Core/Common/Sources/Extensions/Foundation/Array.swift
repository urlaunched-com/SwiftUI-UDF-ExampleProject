//
//  Array.swift
//  Flick
//
//  Created by Alexander Sharko on 30.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation

public extension Array {
    subscript(safe range: Range<Index>) -> ArraySlice<Element>? {
        if range.endIndex > endIndex {
            if range.startIndex >= endIndex {
                return nil
            } else { return self[range.startIndex ..< endIndex] }
        } else {
            return self[range]
        }
    }
}
