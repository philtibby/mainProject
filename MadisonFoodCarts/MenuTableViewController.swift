//
//  MenuTableViewController.swift
//  MadisonFoodCarts
//
//  Created by Matt Peterson on 11/1/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import Parse

class MenuTableViewController: UITableViewController {
    
    //array of menu item objects
    var menuItems = [MenuItem]()
    
    var cart : FoodCartMap?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        
        //////////SAMPLE DATA FOR MENU ITEM STORAGE//////////////
        
        var newItem = MenuItem(name: "BLT", cartName: "Jamerica", price: 12.95, info: "Bacon, lettuce, and tomato on a toasted roll")
        
        menuItems.append(newItem)
        
        newItem = MenuItem(name: "Chicken Noodle Soup", cartName:"Jamerica", price: 4.95, info: "Our version of a timeless classic")
        
        menuItems.append(newItem)
        
        newItem = MenuItem(name: "Lasagna", cartName:"Jamerica", price: 29.35, info: "Layers and layers of awesomeness. If you don't think our lasagna is the best you've ever tasted then we will be like woah. Seriously though, this fucking lasagna is the bees knees. It's the cats meow. It takes the breath away. It turns chronic depression into chronic happiness. There is no way a human being could consume our lasagna without having an out of body experience featuring at least 2 of the Beatles, a talking spirit animal, and a monk that doesn't speak but rather understands you. And you him. $29.35 is a small price to pay for this shit. Just order it bro")
        
        menuItems.append(newItem)
        
        */
        
        let query = PFQuery(className:"MenuItems")
        query.whereKey("CartName", equalTo: cart!.cartName!)
        query.findObjectsInBackgroundWithBlock
            {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil
                {
                    // The find succeeded.
                    print("Successfully retrieved \(objects!.count) menu items.")
                    // Do something with the found objects
                    
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            let menuItem = MenuItem(name: object["Name"] as! String,
                                cartName: object["CartName"] as! String,
                                price: object["Price"] as! float_t,
                                info: object["Description"] as! String)
                            
                            self.menuItems.append(menuItem)
                            
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
        return menuItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath)

        // Configure the cell...
        let currentMenuItem = menuItems[indexPath.row]
        
        cell.textLabel?.text = currentMenuItem.name
        
        
        let price = "$\(currentMenuItem.price.description)"
        
        
        cell.detailTextLabel?.text = price

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
        // Get the new view controller using segue.destinationViewController.
        let svc = segue.destinationViewController as! MenuItemInfoViewController
        
        // Pass the selected object to the new view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedItem = menuItems[indexPath.row]
            svc.currentItem = selectedItem
        }
    }
}
