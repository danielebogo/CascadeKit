//
//  Copyright © 2018 YNAP. All rights reserved.
//

import Foundation


/// Custom protocol used for constraining purpose
public protocol Rangeable{ }

extension CountableClosedRange: Rangeable { }
extension CountableRange: Rangeable { }
extension Range: Rangeable { }
