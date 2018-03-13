//
//  Cascade.swift
//  Example
//
//  Created by Daniele Bogo on 11/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import Foundation


/// Name space for string cascade declartion
struct Cascade {
    /// Attribute struct to decorate an attribute string
    struct Attribute {
        var key: NSAttributedStringKey
        var value: Any
        var range: NSRange?
    }
    
    /// String cascade fallback
    struct Fallback {
        var content: String
        var range: CountableClosedRange<Int>

        /// Convert a collection range to NSRange
        ///
        /// - Returns: A NSRange. I can be nil
        func toNSRange() -> NSRange? {
            guard
                let start = Array(self.range).first,
                let last =  Array(self.range).last
                else {
                    return nil
            }
            
            return NSRange(location: start, length: last - start + 1)
        }
    }
}

typealias CascadeAttribute = Cascade.Attribute
typealias CascadeFallback = Cascade.Fallback

