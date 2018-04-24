//
//  Copyright © 2018 YNAP. All rights reserved.
//

import Foundation


/// String cascade fallback
public struct Fallback: Codable {
    let content: String
    let range: CountableClosedRange<Int>
    let type: Alphabet
}


public extension Fallback {
    /// Create a new fallback from a given Fallback
    ///
    /// - Parameter fallback: A valid Fallback
    /// - Returns: A new Fallback if exists
    public func merge(fallback: Fallback) -> Fallback? {
        if range.upperBound != (fallback.range.lowerBound - 1) {
            return nil
        }
        
        return Fallback(content: content + fallback.content,
                        range: range.lowerBound...fallback.range.upperBound,
                        type: type)
    }
}
