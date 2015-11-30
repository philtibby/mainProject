//
//  OwnerCartsTableViewController.swift
//  MadisonFoodCarts
//
//  Created by Matt Peterson on 11/14/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import Parse

class OwnerCartsTableViewController: UITableViewController
{
    var ownerCarts = [FoodCart]()
    
    var theAddedCart: FoodCart?
    
    var thisOwner: String = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print(thisOwner)
        let query = PFQuery(className:"Cart")
        query.whereKey("CartOwner", equalTo: thisOwner)
        query.findObjectsInBackgroundWithBlock
            {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil
                {
                    // The find succeeded.
                    print("Successfully retrieved \(objects!.count) carts.")
                    // Do something with the found objects
                    
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            let cart = FoodCart(cartName: object["CartName"]! as! String,
                                cartOwner: object["CartOwner"] as! String,
                                cuisineType: object["CuisineType"] as! String,
                                message: object["Message"] as! String,
                                isOpen: object["isOpen"] as! Bool)
                            
                                self.ownerCarts.append(cart)
                            
                        }
                        self.tableView.reloadData()
                    }
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
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
                svc.thisCart = selectedCart
            }
        }
        else if (segue.identifier == "addCart")
        {
            // Get the new view controller using segue.destinationViewController.
            let svc = segue.destinationViewController as! AddNewCartViewController
            
            var ownerCartNames = [String]()
            
            for (var i = 0; i < ownerCarts.count; i++)
            {
                ownerCartNames.append(ownerCarts[i].cartName!)
            }
            
            // Pass the selected object to the new view controller.
            svc.cartOwner = thisOwner
            svc.ownerCarts = ownerCartNames
        }
    }
}
