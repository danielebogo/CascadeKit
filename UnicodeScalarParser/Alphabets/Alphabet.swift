//
//  Copyright © 2018 YNAP. All rights reserved.
//

import Foundation


/// Alphabet types
enum Alphabet {
    case arabic
    case greek
    case latin
    case latinSupplementary
    case russian
    case russianSupplementary

    
    /// A valid CountableClosedRange<UInt32> based on Self
    var range: CountableClosedRange<UInt32> {
        switch self {
        case .arabic: return 0x600...0x6FF
        case .greek: return 0x370...0x3FF
        case .latin: return 0x20...0x7F
        case .latinSupplementary: return 0xA0...0xFF
        case .russian: return 0x400...0x4FF
        case .russianSupplementary: return 0x500...0x52F
        }
    }
}
