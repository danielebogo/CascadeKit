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
        self.mapCascade(for: alphabets) { fallback in
            ranges.append(fallback)
        }

        return ranges
    }
    
    func mapCascade(for alphabets: [UnicodeCharactersRange], _ block: (CascadeFallback) -> ()) {
        var index = 0
        var startBound = 0
        var endBound = 0
        var isMatching = false
        
        var cachedScalars: [UnicodeScalar: UnicodeCharactersRange] = [:]
        var type: UnicodeCharactersRange?
        
        for scalar in self.unicodeScalars {
            type = scalar.match(in: alphabets)
            if cachedScalars[scalar] != nil || type != nil {
                if !isMatching {
                    isMatching = true
                    startBound = index
                }
            } else { // not match
                if isMatching {
                    isMatching = false
                    endBound = index - 1
                    if let type = type {
                        block(CascadeFallback(content: substring(collection: startBound...endBound),
                                              range: startBound...endBound,
                                              type: type))
                    }
                }
            }
            
            if let type = type {
                cachedScalars[scalar] = type
            }
            
            index += 1
        }
        
        if let type = type, isMatching {
            endBound = index - 1
            block(CascadeFallback(content: substring(collection: startBound...endBound),
                                  range: startBound...endBound,
                                  type: type))
        }
    }
}
