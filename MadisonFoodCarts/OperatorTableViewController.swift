//
//  OperatorTableViewController.swift
//  MadisonFoodCarts
//
//  Created by Umair Sharif on 11/4/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import Parse

class OperatorTableViewController: UITableViewController {
    
    var operators = [String]()
    
    // var didAddOperator = 0
    
    // var theAddedOperator: String?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let query = PFQuery(className:"Cart")
        query.whereKeyExists("CartOwner")
        query.findObjectsInBackgroundWithBlock
        {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil
            {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) food cart objects.")
                // Do something with the found objects
                
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        if !(self.operators.contains(object["CartOwner"] as! String))
                        {
                            self.operators.append(object["CartOwner"] as! String)
                        }
                    }
                    print("Successfully retrieved \(self.operators.count) operators.")
                    self.tableView.reloadData()
                }
            }
            else
            {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
//        if (didAddOperator == 1)
//        {
//                operators.append(theAddedOperator!)
//                didAddOperator = 0
//                self.tableView.reloadData()
//            
//        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // This action allows the add operator view controller to pop back to here
    @IBAction func exitToHere(segue: UIStoryboardSegue) {
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // return the number of rows
        return operators.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("operatorCell", forIndexPath: indexPath)

        // Configure the cell...

        let currentOperator = operators[indexPath.row]
        
        cell.textLabel!.text = currentOperator
        
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
        if (segue.identifier == "viewCarts")
        {
            let svc = segue.destinationViewController as! OwnerCartsTableViewController
            
            // Pass the selected object to the new view controller.
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                let selectedOperator = operators[indexPath.row]
                svc.thisOwner = selectedOperator
            }
        }
        else if (segue.identifier == "addOperator")
        {
            let svc = segue.destinationViewController as! AddOperatorViewController
            
            svc.operatorList = operators
        }
    }
}