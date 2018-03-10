//: [Previous](@previous)

import Foundation

extension String {
    func substring<C: Collection>(collection: C) -> String where C.Iterator.Element == Int, C: Rangeable {
        guard !collection.isEmpty, let first = collection.first else {
            fatalError("Collection must not be empty")
        }
        
        let range = interval(lowerBound: first, upperBound: (first + Int(collection.count)) - 1)
        return String(self[range.0...range.1])
    }
    
    private func interval(lowerBound: Int, upperBound: Int) -> (Index, Index) {
        return (index(startIndex, offsetBy: lowerBound), index(startIndex, offsetBy: upperBound))
    }
}


protocol Rangeable{ }
extension CountableClosedRange: Rangeable { }

var string = "Hello World"
var range = 2...5
print(string.substring(collection: range))

