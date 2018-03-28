//
//  Copyright © 2018 YNAP. All rights reserved.
//

import Foundation

protocol Rangeable{ }

extension CountableClosedRange: Rangeable { }
extension CountableRange: Rangeable { }
extension Range: Rangeable { }
