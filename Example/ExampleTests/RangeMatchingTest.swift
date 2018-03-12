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
        let match: Bool = "a".unicodeScalars.first?.match(in: [.latin]) ?? false
        XCTAssertTrue(match)
    }
    
    func testUnmatchUnicodeScalar() {
        let match: Bool = "a".unicodeScalars.first?.match(in: [.arabic]) ?? false
        XCTAssertFalse(match)
    }
    
    func testFallbackMatching() {
        let expectation = self.expectation(description: "String matching")
        
        "hello".mapCascade(for: [.latin]) {
            XCTAssertEqual($0.content, "hello")
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
}
