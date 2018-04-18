//
//  Copyright © 2018 YNAP. All rights reserved.
//

import Foundation


/// Name space for string cascade declaration
public struct Cascade {
    /// Attribute struct to decorate an attribute string
    public struct Attribute {
        var key: NSAttributedStringKey
        var value: Any
        var range: CountableClosedRange<Int>
    }
    
    /// String cascade fallback
    public struct Fallback {
        var content: String
        var range: CountableClosedRange<Int>
        var type: Alphabet
    }
}


public typealias CascadeAttribute = Cascade.Attribute
public typealias CascadeFallback = Cascade.Fallback


public extension CascadeFallback {
    /// Create a new fallback from a given Fallback
    ///
    /// - Parameter fallback: A valid Fallback
    /// - Returns: A new Fallback if exists
    public func merge(fallback: Cascade.Fallback) -> Cascade.Fallback? {
        if range.upperBound != (fallback.range.lowerBound - 1) {
            return nil
        }

        return Cascade.Fallback(content: content + fallback.content,
                                range: range.lowerBound...fallback.range.upperBound,
                                type: type)
    }
}
