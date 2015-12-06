//
//  CartMenuListTableViewController.swift
//  MadisonFoodCarts
//
//  Created by Carly Hildebrandt on 11/6/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import Parse

class CartMenuListTableViewController: UITableViewController
{
    var menuItems = [MenuItem]()
    
    var theAddedItem: MenuItem?
    
    var thisCartName: String = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
            print(thisCartName)
            let query = PFQuery(className:"MenuItems")
            query.whereKey("CartName", equalTo: thisCartName)
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
                                
                                menuItem.Id = object.objectId
                            
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //  display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.leftBarButtonItem = self.editButtonItem()
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
        //  return the number of rows
        return menuItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuItemCell", forIndexPath: indexPath)

        // Configure the cell...
        let currentMenuItem = menuItems[indexPath.row]
        
        cell.textLabel?.text = currentMenuItem.name
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let currentMenuItem = menuItems[indexPath.row]
        
        if editingStyle == .Delete
        {
            // Delete the row from the data source
            let query = PFQuery(className:"MenuItems")
            query.whereKey("Name", equalTo: currentMenuItem.name)
            query.findObjectsInBackgroundWithBlock
                {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil
                    {
                        // The find succeeded.
                        print("Successfully retrieved the menu item to be deleted.")
                        // Do something with the found objects
                        
                        if let objects = objects as [PFObject]!
                        {
                            for object in objects
                            {
                            
                                object.deleteInBackground()
                                
                                print("Successfully deleted the menu item")
                            }
                        }
                    }
                    else
                    {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
            }

            
            menuItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        else if editingStyle == .Insert
        {
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
        if (segue.identifier == "editMenuItem")
        {
            // Get the new view controller using segue.destinationViewController.
            let svc = segue.destinationViewController as! CartMenuItemDetailsViewController
            
            // Pass the selected object to the new view controller.
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                let selectedItem = menuItems[indexPath.row]
                
                svc.thisMenuItem = selectedItem
                svc.thisMenuItem!.Id = selectedItem.Id
                svc.thisCartName = thisCartName
            }
        }
        else if (segue.identifier == "addMenuItem")
        {
            let svc = segue.destinationViewController as! AddMenuItemViewController
            
            svc.thisCartName = thisCartName
        }
    }
}













