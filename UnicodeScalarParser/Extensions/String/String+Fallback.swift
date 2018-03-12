//
//  String+Fallback.swift
//  Example
//
//  Created by Daniele Bogo on 09/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import Foundation

extension String {
    func fallbackRanges(for alphabets:[UnicodeCharactersRange]) -> [CascadeFallback] {
        var ranges: [CascadeFallback] = []
        var index = 0
        var startBound = 0
        var endBound = 0
        var isMatching = false

        var cachedScalars: [UnicodeScalar: Bool] = [:]

        for scalar in self.unicodeScalars {
            if cachedScalars[scalar] == true || scalar.match(in: alphabets) {
                if !isMatching {
                    isMatching = true
                    startBound = index
                }
            } else { // not match
                if isMatching {
                    isMatching = false
                    endBound = index - 1
                    ranges.append(CascadeFallback(content: self.substring(collection: startBound...endBound),
                                                  range: startBound...endBound))
                }
            }

            cachedScalars[scalar] = isMatching

            index += 1
        }

        if isMatching {
            endBound = index - 1
            ranges.append(CascadeFallback(content: self.substring(collection: startBound...endBound),
                                          range: startBound...endBound))
        }

        return ranges
    }
    
    
    func mapCascade(for alphabets: [UnicodeCharactersRange], _ block: (CascadeFallback) -> ()) {
        var index = 0
        var startBound = 0
        var endBound = 0
        var isMatching = false
        
        var cachedScalars: [UnicodeScalar: Bool] = [:]
        
        for scalar in self.unicodeScalars {
            if cachedScalars[scalar] == true || scalar.match(in: alphabets) {
                if !isMatching {
                    isMatching = true
                    startBound = index
                }
            } else { // not match
                if isMatching {
                    isMatching = false
                    endBound = index - 1
                    block(CascadeFallback(content: substring(collection: startBound...endBound),
                                          range: startBound...endBound))
                }
            }
            
            cachedScalars[scalar] = isMatching
            
            index += 1
        }
        
        if isMatching {
            endBound = index - 1
            block(CascadeFallback(content: substring(collection: startBound...endBound),
                                  range: startBound...endBound))
        }
    }
}
