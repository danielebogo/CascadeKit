//
//  Copyright © 2018 YNAP. All rights reserved.
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
        let sut = "hello"
        sut.mapCascade(for: [.latin]) {
            XCTAssertEqual($0.content, sut)
            XCTAssertEqual($0.range, 0...(sut.count - 1))
            XCTAssertEqual($0.type, .latin)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
