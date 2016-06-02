//
//  CurrencyPickerClass.swift
//  Money
//
//  Created by Raphael Brunner on 02.06.16.
//  Copyright © 2016 Raphael Brunner. All rights reserved.
//

import Foundation
import UIKit

class CurrencyPickerClass: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerList:[Currency] = [.CHF, .$, .€]
    
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
    
    func getPos(pos:Int) -> Currency {
        return pickerList[pos]
    }
}