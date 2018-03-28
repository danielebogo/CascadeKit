//
//  RangeMatchingTest.swift
//  ExampleTests
//
//  Created by Daniele Bogo on 12/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import XCTest
@testable import Example


class RangeMatchingTest: XCTestCase {
    func testMatchUnicodeScalar() {
        let type: UnicodeCharactersRange = ("a".unicodeScalars.first?.match(in: [.latin]))!
        XCTAssertEqual(type, .latin)
    }
    
    func testUnmatchUnicodeScalar() {
        let type: UnicodeCharactersRange? = "a".unicodeScalars.first?.match(in: [.arabic])
        XCTAssertNil(type)
    }
    
    func testFallbackMatching() {
        let expectation = self.expectation(description: "String matching")
        
        "hello".mapCascade(for: [.latin]) {
            XCTAssertEqual($0.content, "hello")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
