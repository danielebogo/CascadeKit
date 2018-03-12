//
//  UILabel+Fallback.swift
//  Example
//
//  Created by Ennio Masi on 11/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func attributedString(with string: String, on alphabets:  [UnicodeCharactersRange]) {

        let fallbacks = string.fallbackRanges(for: alphabets)
        
        let attribute = NSMutableAttributedString(string: string)
        fallbacks.forEach({ fallback in
            
            guard let range = fallback.toNSRange() else { return }
            
            attribute.addAttribute(.foregroundColor, value: UIColor.red, range: range)
        })
        
        self.attributedText = attribute
    }
}
