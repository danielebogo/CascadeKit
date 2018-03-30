//
//  Copyright © 2018 YNAP. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
    /// Add new attributes for the specified alphabets, handling the cascade fallbacks
    ///
    /// - Parameters:
    ///   - alphabets: A collection of Alphabet
    ///   - block: Returns the Cascade Attributes for the current fallback
    ///
    /// - Returns: A mutable attribute string
    @discardableResult
    func addAttributes(for alphabets: [Alphabet], _ block: @escaping (CascadeFallback) -> [CascadeAttribute]) -> NSMutableAttributedString {
        string.mapCascade(for: alphabets) { [weak self] (fallback) in
            let attributes = block(fallback)

            attributes.forEach{
                self?.addAttribute($0.key, value: $0.value, range: $0.range)
            }
        }
        
        return self
    }
    
    /// Add an attribute to a NSMutableAttributedString passing a CountableClosedRange<Int>
    ///
    /// - Parameters:
    ///   - name: NSAttributedStringKey key value
    ///   - value: A value for the attribute
    ///   - range: A valid CountableClosedRange<Int>
    func addAttribute(_ name: NSAttributedStringKey, value: Any, range: CountableClosedRange<Int>) {
        guard let start = Array(range).first, let last = Array(range).last else {
            return
        }
        
        addAttribute(name, value: value, range: NSRange(location: start, length: last - start + 1))
    }
}
