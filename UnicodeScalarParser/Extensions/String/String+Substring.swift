//
//  String+Substring.swift
//  Example
//
//  Created by Daniele Bogo on 09/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import Foundation


extension String {
    func substring(bounds: CountableClosedRange<Int>) -> String {
        let range = interval(lowerBound: bounds.lowerBound, upperBound: bounds.upperBound)
        return String(self[range.0...range.1])
    }
    
    func substring(bounds: CountableRange<Int>) -> String {
        let range = interval(lowerBound: bounds.lowerBound, upperBound: bounds.upperBound)
        return String(self[range.0..<range.1])
    }
    
    private func interval(lowerBound: Int, upperBound: Int) -> (Index, Index) {
        return (index(startIndex, offsetBy: lowerBound), index(startIndex, offsetBy: upperBound))
    }
}
