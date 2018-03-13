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
        string.mapCascade(for: alphabets) { [weak self] (fallback) in
            let attributes = block(fallback)

            attributes.forEach({ attribute in
                guard let range = attribute.range else { return }

                self?.addAttribute(attribute.key,
                                   value: attribute.value,
                                   range: range)
            })
        }
        
        return self
    }
}
