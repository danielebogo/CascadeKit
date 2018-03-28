//
//  Copyright © 2018 YNAP. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
    @discardableResult
    func addAttributes(for alphabets: [UnicodeCharactersRange], _ block: @escaping (CascadeFallback) -> [CascadeAttribute]) -> NSMutableAttributedString {
        string.mapCascade(for: alphabets) { [weak self] (fallback) in
            let attributes = block(fallback)

            attributes.forEach{
                self?.addAttribute($0.key, value: $0.value, range: $0.range)
            }
        }
        
        return self
    }
    
    func addAttribute(_ name: NSAttributedStringKey, value: Any, range: CountableClosedRange<Int>) {
        guard let start = Array(range).first, let last = Array(range).last else {
            return
        }
        
        addAttribute(name, value: value, range: NSRange(location: start, length: last - start + 1))
    }
}
