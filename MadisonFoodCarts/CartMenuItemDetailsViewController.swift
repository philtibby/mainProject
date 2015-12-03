//
//  CartMenuItemDetailsViewController.swift
//  MadisonFoodCarts
//
//  Created by Carly Hildebrandt on 11/6/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import Parse

class CartMenuItemDetailsViewController: UIViewController
{
    var thisCartName: String?
    
    var thisMenuItem: MenuItem?

    @IBOutlet weak var itemName: UITextField!
    
    @IBOutlet weak var itemDescription: UITextView!
    
    @IBOutlet weak var itemPrice: UITextField!
    
    
    override func viewDidLoad()
    {
        itemName.text = thisMenuItem!.name
        itemDescription.text = thisMenuItem!.info
        itemPrice.text = thisMenuItem!.price.description
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        // Get the new view controller
        let svc = segue.destinationViewController as! CartMenuListTableViewController
        
        let query = PFQuery(className:"MenuItems")
        query.whereKey("Name", equalTo: thisMenuItem!.name)
        query.findObjectsInBackgroundWithBlock
            {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil
                {
                    // The find succeeded.
                    print("Successfully retrieved the menu item to be updated.")
                    // Do something with the found objects
                    
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            object["Name"] = self.itemName.text
                            object["Price"] = Float(self.itemPrice.text!)
                            object["Description"] = self.itemDescription.text
                            object.saveInBackground()
                            
                            print("Successfully updated the menu item details")
                        }
                    }
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
        svc.thisCartName = thisCartName!
    }
}











