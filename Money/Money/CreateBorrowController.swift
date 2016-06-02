//
//  CreateBorrowController.swift
//  Money
//
//  Created by Raphael Brunner on 02.06.16.
//  Copyright © 2016 Raphael Brunner. All rights reserved.
//

import UIKit

class CreateBorrowController: UIViewController {
    
    var borrows:[Borrow]? = []
    var borrowTypeController = TypePickerClass()
    var currencyController = CurrencyPickerClass()
    
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var lastnameText: UITextField!
    @IBOutlet weak var reasonText: UITextField!
    @IBOutlet weak var valueText: UITextField!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var typePicker: UIPickerView!
    
 
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
        guard let reason = reasonText.text else {
            return
        }
        guard let value = valueText.text else {
            return
        }
        guard let val = Double.init(value) else {
            return
        }
        let curr = currencyPicker.selectedRowInComponent(0)
        let borrowt = typePicker.selectedRowInComponent(0)
        
        let borrow = Borrow(firstname: firstname, lastname: lastname, reason: reason, value: val.trimValue(), currency: currencyController.getPos(curr), borrowType: borrowTypeController.getPos(borrowt))
        borrows?.insert(borrow!, atIndex: 0)
        saveBorrows()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBorrows()
        
        self.currencyPicker.dataSource = currencyController
        self.currencyPicker.delegate = currencyController
        
        self.typePicker.delegate = borrowTypeController
        self.typePicker.dataSource = borrowTypeController
    }
    
    // Mark: NSCoding
    
    func saveBorrows() {
        var brws:[Borrow]
        if let list = borrows {
            brws = list
        } else {
            brws = [Borrow]()
        }
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(brws, toFile: Borrow.ArchiveURL.path!)
        if(!isSuccessfulSave){
            print("Failed Storing Borrows")
        }
    }
    
    func loadBorrows() {
        borrows = NSKeyedUnarchiver.unarchiveObjectWithFile(Borrow.ArchiveURL.path!) as? [Borrow]
    }
}
