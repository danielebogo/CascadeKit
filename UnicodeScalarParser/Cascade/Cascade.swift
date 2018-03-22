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
        var range: CountableClosedRange<Int>
    }
    
    /// String cascade fallback
    struct Fallback {
        var content: String
        var range: CountableClosedRange<Int>
        var type: UnicodeCharactersRange
    }
}

typealias CascadeAttribute = Cascade.Attribute
typealias CascadeFallback = Cascade.Fallback

extension Cascade.Fallback {
    func merge(fallback: Cascade.Fallback) -> Cascade.Fallback? {

        if self.range.upperBound != (fallback.range.lowerBound - 1) {

            return nil
        }

        return Cascade.Fallback(content: self.content + fallback.content,
                                range: self.range.lowerBound...fallback.range.upperBound,
                                type: self.type)
    }
}
