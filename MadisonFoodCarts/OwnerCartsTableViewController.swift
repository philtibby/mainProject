//
//  OwnerCartsTableViewController.swift
//  MadisonFoodCarts
//
//  Created by Matt Peterson on 11/14/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit

class OwnerCartsTableViewController: UITableViewController
{
    
    var ownerCarts = [FoodCart]()
    
    var newCartCreated = 0;
    
    var theAddedCart: FoodCart?
    
    var thisOwner: String = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if (newCartCreated == 1)
        {
            ownerCarts.append(theAddedCart!)
            newCartCreated = 0;
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return ownerCarts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cartCell", forIndexPath: indexPath)

        // Configure the cell...
        let currentCart = ownerCarts[indexPath.row]
        
        cell.textLabel?.text = currentCart.cartName

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "viewDetails")
        {
            // Get the new view controller using segue.destinationViewController.
            let svc = segue.destinationViewController as! ViewCartDetailsViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                // Pass the selected object to the new view controller.
                let selectedCart = ownerCarts[indexPath.row]
                /*svc.cartName = selectedCart.cartName
                svc.cuisineType = selectedCart.cuisineType
                svc.ownerMessage = selectedCart.message*/
                svc.thisCart = selectedCart
            }
        }
        else if (segue.identifier == "addCart")
        {
            // Get the new view controller using segue.destinationViewController.
            let svc = segue.destinationViewController as! AddNewCartViewController
            
            // Pass the selected object to the new view controller.
            svc.cartOwner = thisOwner
        }
    }
}
