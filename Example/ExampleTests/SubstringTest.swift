//
//  SubstringTest.swift
//  ExampleTests
//
//  Created by Daniele Bogo on 09/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import XCTest
@testable import Example


class SubstringTest: XCTestCase {
    func testSubstring() {
        let range = 1...4
        XCTAssertEqual("ello", "Hello World".substring(collection: range))
    }
}
