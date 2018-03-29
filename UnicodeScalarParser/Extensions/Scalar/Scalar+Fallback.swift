//
//  Copyright © 2018 YNAP. All rights reserved.
//

import Foundation


extension Unicode.Scalar {
    /// Match the unicode scalar within the alphabet range
    ///
    /// - Parameter alphabets: A collection of Alphabet
    /// - Returns: An Alphabet if exists
    func match(in alphabets: [Alphabet]) -> Alphabet? {
        guard !alphabets.isEmpty, let firstRange = alphabets.first else {
            return nil
        }
        
        if firstRange.range ~= self.value { return firstRange }
        return match(in: Array(alphabets.dropFirst()))
    }
}

