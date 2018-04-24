//
//  Copyright © 2018 YNAP. All rights reserved.
//

import Foundation


public extension String {
    /// Returns a list of CascadeFallback for a given list of Alphabets
    ///
    /// - Parameter alphabets: A given list of Alphabets
    /// - Returns: A list of Fallback
    public func fallbackRanges(for alphabets:[Alphabet]) -> [Fallback] {
        var ranges: [Fallback] = []
        mapCascade(for: alphabets) { fallback in
            ranges.append(fallback)
        }

        return ranges
    }

    /// Map CascadeFallback for a given list of Alphabets
    ///
    /// - Parameters:
    ///   - alphabets: A given list of Aphabets
    ///   - block: Emit the Fallback
    public func mapCascade(for alphabets: [Alphabet], _ block: @escaping (Fallback) -> ()) {
        let fallbacks = Cache.shared.value(for: hashValue)
        if !fallbacks.isEmpty {
            fallbacks.forEach(block)
            return
        }
        
        let transformedScalars = transform(for: alphabets)

        if transformedScalars.isEmpty { return }
        
        let storeBlock = { (fallback: Fallback) in
            Cache.shared.set(value: fallback, for: self.hashValue)
            block(fallback)
        }
        
        if transformedScalars.count == 1 {
            storeBlock(transformedScalars.first!)
        }

        emit(from: transformedScalars, block: storeBlock)
        Cache.shared.synchronize()
    }
    
    
    //MARK: - Private methods
    
    /// Returns a list of `Fallback` based on the input `alphabet`.
    /// Every Fallback will have a 1-spot range, the type based on the input `alphabet` and the identified scalar at that range.
    ///
    /// - Parameter alphabets: A collection of Alphabet
    /// - Returns: A list of Fallback
    private func transform(for alphabets: [Alphabet]) -> [Fallback] {
        let transformedScalars = self.unicodeScalars.enumerated().compactMap { (arg) -> Fallback? in
            let (index, scalar) = arg

            guard let match = scalar.match(in: alphabets) else {
                return nil
            }

            return Fallback(content: String(scalar), range: index...index, type: match)
        }

        return transformedScalars
    }
    
    /// Relies on the `Fallback.merge(:)` method which is able to merge to ranges into a bigger one.
    /// So everytime two ranges are consecutive, a new one is built with the composition of the two scalars and a range based on the union of the two ranges.
    ///
    /// - Parameters:
    ///   - fallbacks: A Fallback collection
    ///   - block: The block to emit passing the Fallback
    private func emit(from fallbacks: [Fallback], block: (Fallback) -> ()) {
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
