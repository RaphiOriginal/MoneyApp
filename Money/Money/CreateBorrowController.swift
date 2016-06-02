//
//  CreateBorrowController.swift
//  Money
//
//  Created by Raphael Brunner on 02.06.16.
//  Copyright © 2016 Raphael Brunner. All rights reserved.
//

import UIKit

class CreateBorrowController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var borrows:[Borrow]? = []
    var pickerList:[Currency] = [.CHF, .$, .€]
    
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var lastnameText: UITextField!
    @IBOutlet weak var reasonText: UITextField!
    @IBOutlet weak var valueText: UITextField!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
 
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
        
        let borrow = Borrow(firstname: firstname, lastname: lastname, reason: reason, value: val, currency: pickerList[curr])
        borrows?.insert(borrow!, atIndex: 0)
        saveBorrows()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBorrows()
        
        self.currencyPicker.dataSource = self
        self.currencyPicker.delegate = self
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row].rawValue
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
