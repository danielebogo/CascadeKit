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

    func mapCascade2(for alphabets: [UnicodeCharactersRange], _ block: (CascadeFallback) -> ()) {

        let transformedScalars = self.unicodeScalars.enumerated().flatMap { (arg) -> Cascade.Fallback? in
            let (index, scalar) = arg

            guard let match = scalar.match(in: alphabets) else {
                return nil
            }

            return Cascade.Fallback(content: String(scalar), range: index...index, type: match)
        }

        if transformedScalars.count == 0 { return }

        if transformedScalars.count == 1 { block(transformedScalars.first!) }

        var fallback: Cascade.Fallback? = transformedScalars.first!

        for currentFallback in transformedScalars.dropFirst() {
            guard let targetFallback = fallback else {
                fallback = currentFallback
                continue
            }

            guard let merged = targetFallback.merge(fallback: currentFallback) else {

                block(targetFallback)
                fallback = nil

                continue
            }

            fallback = merged
        }

        if fallback != nil {
            block(fallback!)
        }
    }

    /*
     import Foundation

     let aa = [1, 2, 3, 6, 7, 8]

     struct Arange {
     var start: Int = 0
     var end: Int = 0
     }

     var myRange = Arange()
     var previousIndex = 1

     aa.enumerated().forEach { (index, a) in
     print("\(index), \(a), \(previousIndex)")
     if a == previousIndex { return }

     if a == previousIndex + 1 {
     previousIndex = previousIndex + 1
     return
     }

     myRange.end = previousIndex
     print("Found \(myRange)")

     if index + 1 < aa.count {
     myRange.start = a
     myRange.end = 0
     previousIndex = myRange.start
     }
     }

     myRange.end = previousIndex
     print("Found \(myRange)")

     */

    func mapCascade(for alphabets: [UnicodeCharactersRange], _ block: (CascadeFallback) -> ()) {
        var index = 0
        var startBound = 0
        var endBound = 0
        var isMatching = false
        
        var cachedScalars: [UnicodeScalar: UnicodeCharactersRange] = [:]
        var type: UnicodeCharactersRange?
        
        for scalar in self.unicodeScalars {
            let matchedType = scalar.match(in: alphabets)
            if cachedScalars[scalar] != nil || matchedType != nil {
                if !isMatching {
                    isMatching = true
                    startBound = index
                    type = matchedType
                }
            } else {
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
            
            if let matchedType = matchedType {
                cachedScalars[scalar] = matchedType
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
