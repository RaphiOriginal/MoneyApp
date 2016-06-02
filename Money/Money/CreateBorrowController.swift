//
//  CreateBorrowController.swift
//  Money
//
//  Created by Raphael Brunner on 02.06.16.
//  Copyright © 2016 Raphael Brunner. All rights reserved.
//

import UIKit

class CreateBorrowController: UIViewController {
    
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var lastnameText: UITextField!
    @IBOutlet weak var valueText: UITextField!
    
 
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func done(sender: UIBarButtonItem) {
        guard let firstname = firstnameText.text else {
            return
        }
        guard let lastname = lastnameText.text else {
            return
        }
        guard let value = valueText.text else {
            return
        }
        guard let val = Double.init(value) else {
            return
        }
        let borrow = Borrow(firstname: firstname, lastname: lastname, value: val, currency: .CHF)
        print(borrow.firstname)
    }
}
