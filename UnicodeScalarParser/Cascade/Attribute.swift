//
//  Copyright © 2018 YNAP. All rights reserved.
//

import Foundation


/// Attribute struct to decorate an attribute string
public struct Attribute {
    var key: NSAttributedStringKey
    var value: Any
    var range: CountableClosedRange<Int>
}
