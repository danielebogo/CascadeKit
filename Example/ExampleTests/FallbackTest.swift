//
//  FallbackTest.swift
//  ExampleTests
//
//  Created by Daniele Bogo on 09/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import XCTest
@testable import Example


class FallbackTest: XCTestCase {
    let content = "ciao"
    let range = 0...3
    let fallback: Fallback = Fallback(content: "ciao",
                                      range: 0...3)
    
    
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
