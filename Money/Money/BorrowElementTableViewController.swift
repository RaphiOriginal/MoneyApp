//
//  BorrowElementTableViewController.swift
//  Money
//
//  Created by Raphael Brunner on 02.06.16.
//  Copyright © 2016 Raphael Brunner. All rights reserved.
//

import UIKit

class BorrowElementTableViewController: UITableViewController, UIActivityItemSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBorrows()
    }
    
    var borrows:[Borrow]? = [Borrow]()
    var selectedBorrow:Borrow?
    
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
        cell.value.text = String(format: "%.2f", borrow.value)
        
        switch borrow.borrowType {
        case .Borrowed:
            cell.value.textColor = UIColor.redColor()
        case .Lend:
            cell.value.textColor = UIColor.greenColor()
        }
        
        return cell
    }
    
    // Mark: Row Buttons
    
    /*override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            borrows?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            saveBorrows()
        }
    }*/
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            self.borrows?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.saveBorrows()
        }
        
        let shareClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            self.selectedBorrow = self.borrows![indexPath.row]
            
            let activityVC = UIActivityViewController(activityItems: [self], applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
                
            //activityVC.popoverPresentationController?.sourceView = self
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: deleteClosure)
        let shareAction = UITableViewRowAction(style: .Normal, title: "Share", handler: shareClosure)
        shareAction.backgroundColor = UIColor.blueColor()
        
        return [deleteAction, shareAction]
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // Intentionally blank. Required to use UITableViewRowActions
    }
    
    // Mark: Sharing Stuff
    
    func activityViewControllerPlaceholderItem(activityViewController: UIActivityViewController) -> AnyObject {
        return "Money"
    }
    
    func activityViewController(activityViewController: UIActivityViewController, itemForActivityType activityType: String) -> AnyObject? {
        let textToShare:String
        let borrow = self.selectedBorrow!
        
        switch borrow.borrowType {
        case .Borrowed:
            textToShare = "Borrowed from \(borrow.firstname) \(borrow.lastname) \(String(format: "%.2f", borrow.value))\(borrow.currency.rawValue) for \(borrow.reason)"
        case .Lend:
            textToShare = "Lent to \(borrow.firstname) \(borrow.lastname) \(String(format: "%.2f", borrow.value))\(borrow.currency.rawValue) for \(borrow.reason)"
        }
        
        switch activityType {
            
        case let x where [UIActivityTypePostToFacebook, UIActivityTypePostToTwitter].contains(x):
            // Returns text for social media services
            return textToShare
            
        case UIActivityTypeMail:
            // Returns long text for email
            return textToShare
            
        case let x where [UIActivityTypeCopyToPasteboard].contains(x):
            return textToShare
            
        default:
            return textToShare
        }
    }
    
    // Mark: FileManager Stuff
    
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
