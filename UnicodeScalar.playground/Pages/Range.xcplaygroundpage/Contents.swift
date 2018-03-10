//: [Previous](@previous)

import Foundation

extension String {
    func substring<C: RandomAccessCollection>(collection: C) -> String where C.Iterator.Element == Int {
        guard !collection.isEmpty, let first = collection.first else {
            fatalError("Collection must not be empty")
        }
        
        let range = interval(lowerBound: first, upperBound: (first + Int(collection.count)) - 1)
        return String(self[range.0...range.1])
    }
    
    func substring(bounds: CountableClosedRange<Int>) -> String {
        let range = interval(lowerBound: bounds.lowerBound, upperBound: bounds.upperBound)
        return String(self[range.0...range.1])
    }
    
    private func interval(lowerBound: Int, upperBound: Int) -> (Index, Index) {
        return (index(startIndex, offsetBy: lowerBound), index(startIndex, offsetBy: upperBound))
    }
}

var string = "Hello World"
var range = 2...5
print(string.substring(collection: range))
print("---")
print(string.substring(bounds: range))

print(string.substring(collection: [3, 5, 7]))

