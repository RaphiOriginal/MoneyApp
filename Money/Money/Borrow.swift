//
//  Borrow.swift
//  Money
//
//  Created by Raphael Brunner on 02.06.16.
//  Copyright © 2016 Raphael Brunner. All rights reserved.
//

import Foundation

class Borrow: NSObject, NSCoding {
    
    var firstname:String
    var lastname:String
    var reason:String
    var value:Double
    var currency:Currency
    
    init?(firstname:String, lastname:String, reason:String, value:Double, currency:Currency){
        self.firstname = firstname
        self.lastname = lastname
        self.reason = reason
        self.value = value
        self.currency = currency
        super.init()
    }
    
    // Mark: Types
    
    struct PropertyKey {
        static let firstname = "firstname"
        static let lastname = "lastname"
        static let reason = "reason"
        static let value = "value"
        static let currency = "currency"
    }
    
    // Mark: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("Borrows")
    
    // Mark: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(firstname, forKey: PropertyKey.firstname)
        aCoder.encodeObject(lastname, forKey: PropertyKey.lastname)
        aCoder.encodeObject(reason, forKey: PropertyKey.reason)
        aCoder.encodeDouble(value, forKey: PropertyKey.value)
        aCoder.encodeObject(currency.rawValue, forKey: PropertyKey.currency)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let firstname = aDecoder.decodeObjectForKey(PropertyKey.firstname) as! String
        let lastname = aDecoder.decodeObjectForKey(PropertyKey.lastname) as! String
        let reason = aDecoder.decodeObjectForKey(PropertyKey.reason) as! String
        let value = aDecoder.decodeDoubleForKey(PropertyKey.value) as Double
        let curr = aDecoder.decodeObjectForKey(PropertyKey.currency) as! String
        
        let currency = Currency(rawValue: curr)!
        
        self.init(firstname: firstname, lastname: lastname, reason: reason, value: value, currency: currency)
    }
}
