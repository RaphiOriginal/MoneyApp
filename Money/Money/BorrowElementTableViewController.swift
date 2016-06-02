//
//  BorrowElementTableViewController.swift
//  Money
//
//  Created by Raphael Brunner on 02.06.16.
//  Copyright © 2016 Raphael Brunner. All rights reserved.
//

import UIKit

class BorrowElementTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBorrows()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    var borrows = [Borrow]()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return borrows.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BorrowElementCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BorrowElementCell
        
        // Configure the cell...
        let borrow = borrows[indexPath.row]
        
        cell.firstname.text = borrow.firstname
        cell.lastname.text = borrow.lastname
        cell.currency.text = borrow.currency.rawValue
        cell.value.text = borrow.value.description
        
        return cell
    }
    
    func loadBorrows() -> () {
        print("load examples")
        borrows.append(Borrow(firstname: "Hans", lastname: "Joachim", value: 12.90, currency: .CHF))
        borrows.append(Borrow(firstname: "Sepp", lastname: "Blatter", value: 30000.05, currency: .CHF))
        borrows.append(Borrow(firstname: "Julia", lastname: "Bachmann", value: 1.00, currency: .CHF))
    }

}
