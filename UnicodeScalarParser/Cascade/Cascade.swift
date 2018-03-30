//
//  Copyright © 2018 YNAP. All rights reserved.
//

import Foundation

/// Name space for string cascade declaration
struct Cascade {
    /// Attribute struct to decorate an attribute string
    ///
    /// With this `Attribute` you can apply a specific style to the characters
    /// included in the `range` field.
    struct Attribute {
        var key: NSAttributedStringKey
        var value: Any
        var range: CountableClosedRange<Int>
    }
    
    /// String cascade fallback
    ///
    /// The `Fallback` maps a content with its range in the original string and
    /// the alphabet in which it's been written.
    struct Fallback {
        var content: String
        var range: CountableClosedRange<Int>
        var type: Alphabet
    }
}

typealias CascadeAttribute = Cascade.Attribute
typealias CascadeFallback = Cascade.Fallback

extension Cascade.Fallback {
    /// Create a new fallback from a given Fallback
    ///
    /// - Parameter fallback: A valid Fallback
    /// - Returns: A new Fallback if exists
    func merge(fallback: Cascade.Fallback) -> Cascade.Fallback? {
        if range.upperBound != (fallback.range.lowerBound - 1) {
            return nil
        }

        return Cascade.Fallback(content: content + fallback.content,
                                range: range.lowerBound...fallback.range.upperBound,
                                type: type)
    }
}
