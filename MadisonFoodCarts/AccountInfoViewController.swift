//
//  AccountInfoViewController.swift
//  MadisonFoodCarts
//
//  Created by Carly Hildebrandt on 12/12/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import Parse

class AccountInfoViewController: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var accntBanner: UILabel!
    
    @IBOutlet weak var currPassword: UITextField!
    
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var newPassword2: UITextField!
    
    var ownerName = ""
    
    var match = false
    
    var choseToDelete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accntBanner.text = ownerName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // For clicking save changes button to change password
    @IBAction func saveChanges(sender: AnyObject) {
        
            let query = PFQuery(className:"Operator")
            query.whereKey("username", equalTo: ownerName)
            do {
                let objects = try query.findObjects()
                if let objects = objects as [PFObject]! {
                    for object in objects
                    {
                        if (self.currPassword.text! == (object["password"] as! String)) {
                            print("match found")
                            self.match = true
                        }
                        else {
                            let alertController = UIAlertController(title: "Oops!", message: "Incorrect current password", preferredStyle: .Alert)
                            
                            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                                // ...
                            }
                            alertController.addAction(OKAction)
                            
                            self.presentViewController(alertController, animated: true) {
                                // ...
                            }
                        }
                        if (self.match && newPassword.text!.characters.count >= 8)
                        {
                            if (newPassword.text == newPassword2.text)
                            {
                                print("here")
                                object["password"] = newPassword.text!
                                try object.save()
                                self.match = false
                                newPassword2.text = ""
                                newPassword.text = ""
                                currPassword.text = ""
                                message.text = "Your password was successfully changed!"
                            }
                            else {
                                let alertController = UIAlertController(title: "Oops!", message: "New passwords don't match", preferredStyle: .Alert)
                                
                                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                                    // ...
                                }
                                alertController.addAction(OKAction)
                                
                                self.presentViewController(alertController, animated: true) {
                                    // ...
                                }
                            }
                        }
                        else {
                            let alertController = UIAlertController(title: "Oops!", message: "Make sure new password has at least 8 characters", preferredStyle: .Alert)
                            
                            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                                // ...
                            }
                            alertController.addAction(OKAction)
                            
                            self.presentViewController(alertController, animated: true) {
                                // ...
                            }
                        }
                    }
                }
                else {
                    print("something didnt work - changing password")
                }
            }
            catch {
                print("error in changing password occurred")
            }
 
    }
    
    @IBAction func deleteAccnt(sender: AnyObject) {
    
            let alertController = UIAlertController(title: "Are you sure you wish to delete your account?", message: "This cannot be undone.", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                // ...
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "Proceed", style: .Default)
                { (action) in
                    // Delete the menu items associated with the carts first
                    let cartQuery = PFQuery(className: "Cart")
                    cartQuery.whereKey("CartOwner", equalTo: self.ownerName)
                    cartQuery.findObjectsInBackgroundWithBlock
                        {
                            (objects1: [PFObject]?, error: NSError?) -> Void in
                            if error == nil {
                                if let carts = objects1 as [PFObject]!
                                {
                                    for cart in carts
                                    {
                                        let query = PFQuery(className:"MenuItems")
                                        query.whereKey("CartName", equalTo: cart["CartName"])
                                        query.findObjectsInBackgroundWithBlock
                                            {
                                                (objects2: [PFObject]?, error: NSError?) -> Void in
                                                
                                                if error == nil
                                                {
                                                    // Do something with the found objects
                                                    
                                                    if let items = objects2 as [PFObject]!
                                                    {
                                                        for item in items
                                                        {
                                                            
                                                            item.deleteInBackground()
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
                                        
                                        cart.deleteInBackground()
                                    }
                                    print("Successfully deleted all carts")
                                }
                                
                            }
                            else {
                                print("error deleting carts")
                            }
                    }
                    
                    let query = PFQuery(className:"Operator")
                    query.whereKey("username", equalTo: self.ownerName)
                    query.findObjectsInBackgroundWithBlock
                        {
                            (objects: [PFObject]?, error: NSError?) -> Void in
                            
                            if error == nil
                            {
                                // Do something with the found objects
                                
                                if let objects = objects as [PFObject]!
                                {
                                    for object in objects
                                    {
                                        
                                        object.deleteInBackground()
                                    }
                                    print("Successfully deleted the user's account")
                                }
                            }
                            else
                            {
                                // Log details of the failure
                                print("Error: \(error!) \(error!.userInfo)")
                            }
                            
                    }
                    
                    //Pop back to initial view controller
                    
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("nav") as! UINavigationController
                    self.presentViewController(vc, animated: true, completion: nil)
                    
                    
            }
            
            
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) {
                // ...
            }
    

    
        }
    
    
    
//    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
//    {
//        
//        
//        
//   
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
