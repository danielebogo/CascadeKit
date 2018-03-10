//
//  String+Fallback.swift
//  Example
//
//  Created by Daniele Bogo on 09/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import Foundation


extension String {
    func fallbacks(_ criteria:(Unicode.Scalar) -> Bool) -> [Fallback] {
        var ranges: [Fallback] = []
        var index = 0
        var startBound = 0
        var endBound = 0
        var isMatching = false
        
        for scalar in self.unicodeScalars {
            if criteria(scalar) { // match
                if !isMatching {
                    isMatching = true
                    startBound = index
                }
            } else { // not match
                if isMatching {
                    isMatching = false
                    endBound = index - 1
                    ranges.append(Fallback(content: substring(collection: startBound...endBound),
                                           range: startBound...endBound))
                }
            }
            
            index += 1
        }
        
        if isMatching {
            endBound = index - 1
            ranges.append(Fallback(content: substring(collection: startBound...endBound),
                                   range: startBound...endBound))
        }
        
        return ranges
    }
}
