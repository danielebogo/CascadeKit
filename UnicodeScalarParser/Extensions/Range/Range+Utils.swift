//
//  Range+Utils.swift
//  Example
//
//  Created by Daniele Bogo on 10/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import Foundation

protocol Rangeable{ }

extension CountableClosedRange: Rangeable { }
extension CountableRange: Rangeable { }
extension Range: Rangeable { }
