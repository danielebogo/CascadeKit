//
//  Fallback.swift
//  Example
//
//  Created by Daniele Bogo on 09/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import Foundation

struct Fallback {
    var content: String
    var range: CountableClosedRange<Int>
}

extension Fallback {
    func toRange() -> NSRange? {
        guard
            let start = Array(self.range).first,
            let last =  Array(self.range).last
            else {
                return nil
        }
        
        return NSRange(location: start, length: last - start + 1)
    }
}
