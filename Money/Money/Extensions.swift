//
//  Extensions.swift
//  Money
//
//  Created by Raphael Brunner on 02.06.16.
//  Copyright © 2016 Raphael Brunner. All rights reserved.
//

import Foundation

extension Double {
    func trimValue() -> Double {
        return Double(round(100*self)/100)
    }
}