//
//  Copyright © 2018 YNAP. All rights reserved.
//

import XCTest
@testable import Example


class FallbackTest: XCTestCase {
    let content = "Hello"
    let range = 0...3
    let fallback: Fallback = Fallback(content: "Hello",
                                      range: 0...3,
                                      type: .arabic)
    
    func testFallback() {
        XCTAssertNotNil(fallback)
    }
    
    func testFallbackContent() {
        XCTAssertEqual(fallback.content, content)
    }
    
    func testFallbackRange() {
        XCTAssertTrue(fallback.range == range)
    }
}
