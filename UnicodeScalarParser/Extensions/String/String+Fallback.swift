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

        let transformedScalars = self.transform(for: alphabets)

        if transformedScalars.isEmpty { return }

        if transformedScalars.count == 1 { block(transformedScalars.first!) }

        self.emit(from: transformedScalars, block: block)
    }

    /*
     This method returns a list of `Cascade.Fallback` based on the input `alphabet`.

     Every Cascade.Fallback will have a 1-spot range, the type based on the input `alphabet` and
     the identified scalar at that range.
     */
    fileprivate func transform(for alphabets: [UnicodeCharactersRange]) -> [Cascade.Fallback] {
        let transformedScalars = self.unicodeScalars.enumerated().flatMap { (arg) -> Cascade.Fallback? in
            let (index, scalar) = arg

            guard let match = scalar.match(in: alphabets) else {
                return nil
            }

            return Cascade.Fallback(content: String(scalar), range: index...index, type: match)
        }

        return transformedScalars
    }

    /*
     This method relies on the `Cascade.fallback.merge(:)` method which is able to merge to ranges into
     a bigger one.

     So everytime two ranges are consecutive, a new one is built with the composition of the two scalars
     and a range based on the union of the two ranges.
     */
    fileprivate func emit(from fallbacks: [Cascade.Fallback], block: (CascadeFallback) -> ()) {
        guard var fallback = fallbacks.first else {
            return
        }

        for currentFallback in fallbacks.dropFirst() {
            guard let merged = fallback.merge(fallback: currentFallback) else {
                block(fallback)
                fallback = currentFallback

                continue
            }

            fallback = merged
        }

        block(fallback)
    }
}
