//: Playground - noun: a place where people can play

import UIKit
import Foundation


let latinRanges: [CountableClosedRange<UInt32>] = [0x41...0x5A, 0x61...0x7A, 0xC0...0xFF, 0x100...0x17F]
let arabicRanges: [CountableClosedRange<UInt32>] = [0x600...0x6FF]

var string = "Hi mate! عن الCIAOتركيز "

struct Fallback {
    var substring: String
    var range: CountableClosedRange<Int>
}

extension Unicode.Scalar {
    func match(in ranges: [CountableClosedRange<UInt32>]) -> Bool {
        if ranges.isEmpty { return false }
        
        guard let firstRange = ranges.first else { return false }
        
        if firstRange ~= self.value { return true }
        
        return match(in: Array(ranges.dropFirst()))
    }
}

extension String {
    func fallbackRanges(_ criteria:(Unicode.Scalar) -> Bool) -> [Fallback] {
        var ranges: [Fallback] = []
        var index = 0
        var startBound = 0
        var endBound = 0
        var isMatching = false
        
        for scalar in self.unicodeScalars {
            if criteria(scalar) {
                if !isMatching {
                    isMatching = true
                    startBound = index
                }
            } else {
                if isMatching {
                    isMatching = false
                    endBound = index - 1
                    ranges.append(Fallback(substring: self.substring(bounds: startBound...endBound),
                                           range: startBound...endBound))
                }
            }
            
            index += 1
        }
        
        return ranges
    }
}

extension String {
    fileprivate func interval(lowerBound: Int, upperBound: Int) -> (Index, Index) {
        return (index(startIndex, offsetBy: lowerBound), index(startIndex, offsetBy: upperBound))
    }
    
    func substring(bounds: CountableClosedRange<Int>) -> String {
        let range = interval(lowerBound: bounds.lowerBound, upperBound: bounds.upperBound)

        return String(self[range.0...range.1])
    }
    
    func substring(bounds: CountableRange<Int>) -> String {
        let range = interval(lowerBound: bounds.lowerBound, upperBound: bounds.upperBound)
        
        return String(self[range.0..<range.1])
    }
}

let ranges = string.fallbackRanges { $0.match(in: latinRanges) }
print(ranges)
