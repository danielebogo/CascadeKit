//
//  Scalar+Fallback.swift
//  Example
//
//  Created by Daniele Bogo on 09/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import Foundation

extension Unicode.Scalar {
    func match(in ranges: [UnicodeCharactersRange]) -> UnicodeCharactersRange? {
        guard !ranges.isEmpty, let firstRange = ranges.first else {
            return nil
        }
        
        if firstRange.range ~= self.value { return firstRange }
        
        return match(in: Array(ranges.dropFirst()))
    }
}
