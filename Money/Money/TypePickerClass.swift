//
//  TypePickerClass.swift
//  Money
//
//  Created by Raphael Brunner on 02.06.16.
//  Copyright © 2016 Raphael Brunner. All rights reserved.
//

import Foundation
import UIKit

class TypePickerClass: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var borrowList:[BorrowType] = [.Borrowed, .Lend]
    
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return borrowList.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return borrowList[row].rawValue
    }
    
    func getPos(pos:Int) -> BorrowType{
        return borrowList[pos]
    }
}