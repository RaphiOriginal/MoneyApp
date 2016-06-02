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
    }
    
    var borrows:[Borrow]? = [Borrow]()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = borrows else {
            return 0
        }
        return list.count
    }
    
    override func viewDidAppear(animated: Bool) {
        loadBorrows()
        print(borrows)
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BorrowElementCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BorrowElementCell
        
        // Configure the cell...
        let borrow = borrows![indexPath.row]
        
        cell.firstname.text = borrow.firstname
        cell.lastname.text = borrow.lastname
        cell.reason.text = borrow.reason
        cell.currency.text = borrow.currency.rawValue
        cell.value.text = borrow.value.description
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            borrows?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            saveBorrows()
        }
    }
    
    func loadBorrows() -> () {
        borrows = NSKeyedUnarchiver.unarchiveObjectWithFile(Borrow.ArchiveURL.path!) as? [Borrow]
    }
    
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

}
