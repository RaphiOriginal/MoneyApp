//
//  CreateBorrowController.swift
//  Money
//
//  Created by Raphael Brunner on 02.06.16.
//  Copyright © 2016 Raphael Brunner. All rights reserved.
//

import UIKit

class CreateBorrowController: UIViewController, UITextFieldDelegate{
    
    var borrows:[Borrow]? = []
    var borrowTypeController = TypePickerClass()
    var currencyController = CurrencyPickerClass()
    
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var lastnameText: UITextField!
    @IBOutlet weak var reasonText: UITextField!
    @IBOutlet weak var valueText: UITextField!
    @IBOutlet weak var currencyPickerField: UITextField!
    @IBOutlet weak var typePickerField: UITextField!
    
 
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
        guard let curr = currencyPickerField.text else {
            return
        }
        guard let borrowt = typePickerField.text else {
            return
        }
        
        let borrow = Borrow(firstname: firstname, lastname: lastname, reason: reason, value: val.trimValue(), currency: Currency(rawValue: curr)!, borrowType: BorrowType(rawValue: borrowt)!)
        borrows?.insert(borrow!, atIndex: 0)
        saveBorrows()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBorrows()
        
        let currencyPickerView = UIPickerView()
        let typePickerView = UIPickerView()
        
        currencyPickerView.delegate = currencyController
        typePickerView.delegate = borrowTypeController
        
        currencyController.textField = currencyPickerField
        borrowTypeController.textField = typePickerField
        
        currencyPickerField.inputView = currencyPickerView
        typePickerField.inputView = typePickerView
        
        
        self.firstnameText.delegate = self
        self.lastnameText.delegate = self
        self.valueText.delegate = self
        self.reasonText.delegate = self
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
