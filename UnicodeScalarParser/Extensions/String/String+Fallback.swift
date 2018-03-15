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
        struct ScalarFound {
            var index: Int
            var scalar: Unicode.Scalar
            var type: UnicodeCharactersRange
        }

        var transformedScalars = self.unicodeScalars.enumerated().flatMap { (arg) -> ScalarFound? in
            let (index, scalar) = arg

            guard let match = scalar.match(in: alphabets) else {
                return nil
            }

            return ScalarFound(index: index, scalar: scalar, type: match)
        }

        if transformedScalars.count == 0 { return }

        let firstScalar = transformedScalars.first!

        var cascadeFallback = CascadeFallback(content: String(firstScalar.scalar), range: firstScalar.index...firstScalar.index, type: firstScalar.type)

        transformedScalars = Array(transformedScalars.dropFirst())

        var startIndex = firstScalar.index
        var previousScalarIndex = 0
        transformedScalars.forEach { scalarFound in
            if startIndex == -1 {
                startIndex = scalarFound.index
                previousScalarIndex = startIndex
            }

            if scalarFound.index == previousScalarIndex + 1 {
                previousScalarIndex = previousScalarIndex  + 1
                return
            }

            if startIndex == previousScalarIndex { return }

            let newRange: CountableClosedRange<Int> = startIndex...previousScalarIndex

            cascadeFallback = CascadeFallback(content: cascadeFallback.content, range: newRange, type: cascadeFallback.type)
            block(cascadeFallback)

            startIndex = -1
            previousScalarIndex = -1
        }
    }

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
