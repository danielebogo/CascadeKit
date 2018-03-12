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
        attributedText = NSMutableAttributedString(string: string).addAttributes(for: alphabets) {
            CascadeAttribute(key: .foregroundColor,
                             value: UIColor.red,
                             range: $0.toNSRange())
        }
    }
}
