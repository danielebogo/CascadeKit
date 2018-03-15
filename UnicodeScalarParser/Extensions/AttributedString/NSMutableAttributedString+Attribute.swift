//
//  NSMutableAttributedString+Attribute.swift
//  Example
//
//  Created by Daniele Bogo on 12/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
    @discardableResult
    func addAttributes(for alphabets: [UnicodeCharactersRange], _ block: @escaping (CascadeFallback) -> [CascadeAttribute]) -> NSMutableAttributedString {
        string.mapCascade2(for: alphabets) { [weak self] (fallback) in
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
