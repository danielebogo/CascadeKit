//
//  Copyright © 2018 YNAP. All rights reserved.
//

import XCTest
@testable import Example

class SubstringTest: XCTestCase {
    func testSubstring() {
        let range = 1...4
        XCTAssertEqual("ello", "Hello World".substring(collection: range))
    }
}
