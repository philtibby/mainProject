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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        print("Cart view appeared")
        
        // append the newly added menu item IF there is one
        if (theAddedCart != nil) {
            self.ownerCarts.append(theAddedCart!)
        }
        theAddedCart = nil
        self.tableView.reloadData()
    }
    
    

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
                                isOpen: object["isOpen"] as! Bool
                                )
                            cart.Id = object.objectId!
                            
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
    
    // This action allows the add new cart view controller to pop back to here
    @IBAction func exitToHere(segue: UIStoryboardSegue) {
        
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
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        //let currentMenuItem = menuItems[indexPath.row]
        let currentFoodCart = ownerCarts[indexPath.row]
        
        if editingStyle == .Delete
        {
            let alertController = UIAlertController(title: "Are you sure you wish to delete '\(currentFoodCart.cartName!)'?", message: "This cannot be undone.", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                // ...
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "Proceed", style: .Default) { (action) in
                // ...
                // Delete the menu items associated with the cart first
                var query = PFQuery(className:"MenuItems")
                query.whereKey("CartName", equalTo: currentFoodCart.cartName!)
                query.findObjectsInBackgroundWithBlock
                    {
                        (objects: [PFObject]?, error: NSError?) -> Void in
                        
                        if error == nil
                        {
                            // The find succeeded.
                            print("Successfully retrieved the menu items to be deleted.")
                            // Do something with the found objects
                            
                            if let objects = objects as [PFObject]!
                            {
                                for object in objects
                                {
                                    
                                    object.deleteInBackground()
                                }
                                print("Successfully deleted the menu items")
                            }
                        }
                        else
                        {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                }
                // Then delete the food cart from the database
                query = PFQuery(className:"Cart")
                query.whereKey("CartName", equalTo: currentFoodCart.cartName!)
                query.findObjectsInBackgroundWithBlock
                    {
                        (objects: [PFObject]?, error: NSError?) -> Void in
                        
                        if error == nil
                        {
                            // The find succeeded.
                            print("Successfully retrieved the food cart to be deleted.")
                            // Do something with the found objects
                            
                            if let objects = objects as [PFObject]!
                            {
                                for object in objects
                                {
                                    
                                    object.deleteInBackground()
                                }
                                print("Successfully deleted the food cart")
                            }
                        }
                        else
                        {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                }
                
                self.ownerCarts.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                // ...
            }
            
            /*
            // Delete the menu items associated with the cart first
            var query = PFQuery(className:"MenuItems")
            query.whereKey("CartName", equalTo: currentFoodCart.cartName!)
            query.findObjectsInBackgroundWithBlock
                {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil
                    {
                        // The find succeeded.
                        print("Successfully retrieved the menu items to be deleted.")
                        // Do something with the found objects
                        
                        if let objects = objects as [PFObject]!
                        {
                            for object in objects
                            {
                                
                                object.deleteInBackground()
                            }
                            print("Successfully deleted the menu items")
                        }
                    }
                    else
                    {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
            }
            // Then delete the food cart from the database
            query = PFQuery(className:"Cart")
            query.whereKey("CartName", equalTo: currentFoodCart.cartName!)
            query.findObjectsInBackgroundWithBlock
                {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil
                    {
                        // The find succeeded.
                        print("Successfully retrieved the food cart to be deleted.")
                        // Do something with the found objects
                        
                        if let objects = objects as [PFObject]!
                        {
                            for object in objects
                            {
                                
                                object.deleteInBackground()
                            }
                            print("Successfully deleted the food cart")
                        }
                    }
                    else
                    {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
            }

            ownerCarts.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            */
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
        var ownerCartNames = [String]()
        
        for (var i = 0; i < ownerCarts.count; i++)
        {
            ownerCartNames.append(ownerCarts[i].cartName!)
        }
        
        if (segue.identifier == "viewDetails")
        {
            // Get the new view controller using segue.destinationViewController.
            let svc = segue.destinationViewController as! ViewCartDetailsViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                // Pass the selected object to the new view controller.
                let selectedCart = ownerCarts[indexPath.row]
                svc.thisCart = selectedCart
                svc.ownerCarts = ownerCartNames
            }
        }
        else if (segue.identifier == "addCart")
        {
            // Get the new view controller using segue.destinationViewController.
            let svc = segue.destinationViewController as! AddNewCartViewController
            
            
            
            // Pass the selected object to the new view controller.
            svc.cartOwner = thisOwner
            svc.ownerCarts = ownerCartNames
        }
    }
}
