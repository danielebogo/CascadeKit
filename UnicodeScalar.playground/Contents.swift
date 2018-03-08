//: Playground - noun: a place where people can play

import UIKit


//: [Previous](@previous)

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
        for r in ranges {
            if r ~= self.value {
                return true
            }
        }
        
        return false
    }
}

extension String {
    func fallbackRanges(_ block:(Unicode.Scalar) -> Bool) -> [Fallback] {
        var ranges: [Fallback] = []
        var index = 0
        var startBound = 0
        var endBound = 0
        var isMatching = false
        for s in self.unicodeScalars {
            if block(s) {
                if !isMatching {
                    isMatching = true
                    startBound = index
                }
                
                index += 1
                continue
            }
            
            if isMatching {
                isMatching = false
                endBound = index - 1
                ranges.append(Fallback(substring: self.substring(bounds: startBound...endBound),
                                       range: startBound...endBound))
            }
            
            index += 1
        }
        
        return ranges
    }
}

extension String {
    func substring(bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    func substring(bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

let ranges = string.fallbackRanges { $0.match(in: latinRanges) }
print(ranges)

