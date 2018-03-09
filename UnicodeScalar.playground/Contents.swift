//: Playground - noun: a place where people can play

import UIKit
import Foundation


enum UnicodeCharactersRange {
    case arabic
    case russian
    case russianSupplementary
    case latin
    case latinSupplementary
    case greek

    var range: CountableClosedRange<UInt32> {
        switch self {
        case .arabic: return 0x600...0x6FF
            
        case .russian: return 0x400...0x4FF
        case .russianSupplementary: return 0x500...0x52F

        case .latin: return 0x20...0x7F
        case .latinSupplementary: return 0xA0...0xFF
            
        case .greek: return 0x370...0x3FF
        }
    }
}

struct Fallback {
    var content: String
    var range: CountableClosedRange<Int>
}

extension Unicode.Scalar {
    func match(in ranges: [UnicodeCharactersRange]) -> Bool {
        if ranges.isEmpty { return false }

        guard let firstRange = ranges.first else { return false }

        if firstRange.range ~= self.value { return true }

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
            if criteria(scalar) { // match
                if !isMatching {
                    isMatching = true
                    startBound = index
                }
            } else { // not match
                if isMatching {
                    isMatching = false
                    endBound = index - 1
                    ranges.append(Fallback(content: self.substring(bounds: startBound...endBound),
                                           range: startBound...endBound))
                }
            }

            index += 1
        }

        if isMatching {
            endBound = index - 1
            ranges.append(Fallback(content: self.substring(bounds: startBound...endBound),
                                   range: startBound...endBound))
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

var string = "Hi mate! Ϡعن الCIAOتركيز ζϩ F"
let ranges = string.fallbackRanges { $0.match(in: [.arabic]) }
print(ranges)
