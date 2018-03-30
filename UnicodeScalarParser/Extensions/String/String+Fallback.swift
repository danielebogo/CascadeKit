//
//  Copyright © 2018 YNAP. All rights reserved.
//

import Foundation

extension String {
    /// Returns a list of CascadeFallback for a given list of Alphabets
    ///
    /// - Parameter alphabets: A given list of Alphabets
    /// - Returns: A list of CascadeFallback
    func fallbackRanges(for alphabets:[Alphabet]) -> [CascadeFallback] {
        var ranges: [CascadeFallback] = []
        mapCascade(for: alphabets) { fallback in
            ranges.append(fallback)
        }

        return ranges
    }

    /// Map CascadeFallback for a given list of Alphabets
    ///
    /// - Parameters:
    ///   - alphabets: A given list of Aphabets
    ///   - block: Emit the CascadeFallback
    func mapCascade(for alphabets: [Alphabet], _ block: (CascadeFallback) -> ()) {
        let transformedScalars = transform(for: alphabets)

        if transformedScalars.isEmpty { return }

        if transformedScalars.count == 1 {
            block(transformedScalars.first!)
        }

        emit(from: transformedScalars, block: block)
    }

    //MARK: - Private methods
    
    /// Returns a list of `Cascade.Fallback` based on the input `alphabet`.
    /// Every Cascade.Fallback will have a 1-spot range, the type based on the input `alphabet` and the identified scalar at that range.
    ///
    /// - Parameter alphabets: A collection of Alphabet
    /// - Returns: A list of Cascade.Fallback
    private func transform(for alphabets: [Alphabet]) -> [CascadeFallback] {
        let transformedScalars = self.unicodeScalars.enumerated().flatMap { (arg) -> CascadeFallback? in
            let (index, scalar) = arg

            guard let match = scalar.match(in: alphabets) else {
                return nil
            }

            return CascadeFallback(content: String(scalar), range: index...index, type: match)
        }

        return transformedScalars
    }
    
    /// Relies on the `CascadeFallback.merge(:)` method which is able to merge to ranges into a bigger one.
    /// So everytime two ranges are consecutive, a new one is built with the composition of the two scalars and a
    /// range based on the union of the two consecutive ranges.
    ///
    /// - Parameters:
    ///   - fallbacks: A CascadeFallback collection
    ///   - block: The block to emit passing the CascadeFallback
    private func emit(from fallbacks: [CascadeFallback], block: (CascadeFallback) -> ()) {
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
