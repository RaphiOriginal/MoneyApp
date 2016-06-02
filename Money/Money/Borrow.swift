//
//  Borrow.swift
//  Money
//
//  Created by Raphael Brunner on 02.06.16.
//  Copyright © 2016 Raphael Brunner. All rights reserved.
//

import Foundation

class Borrow {
    
    var firstname:String
    var lastname:String
    var value:Double
    var currency:Currency
    
    init(firstname:String, lastname:String, value:Double, currency:Currency){
        self.firstname = firstname
        self.lastname = lastname
        self.value = value
        self.currency = currency
    }
}
