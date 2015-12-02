//
//  AddMenuItemViewController.swift
//  MadisonFoodCarts
//
//  Created by Matt Peterson on 11/29/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import Parse

class AddMenuItemViewController: UIViewController {
    
    

    @IBOutlet weak var itemName: UITextField!
    
    @IBOutlet weak var itemInfo: UITextField!
    
    @IBOutlet weak var itemPrice: UITextField!
    
    var thisCartName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        let svc = segue.destinationViewController as! CartMenuListTableViewController
        
        // Pass the selected object to the new view controller.
        let newMenuItem = PFObject(className:"MenuItems")
        newMenuItem["Name"] = itemName.text
        newMenuItem["CartName"] = thisCartName
        newMenuItem["Price"] = Float(itemPrice.text!)!
        newMenuItem["Description"] = itemInfo.text
        
        newMenuItem.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("New menu item has been saved.")
        }
        
        let newMI = MenuItem(name: itemName.text!, cartName: thisCartName, price: Float(itemPrice.text!)!, info: itemInfo.text!)
        
        svc.theAddedItem = newMI
        svc.thisCartName = thisCartName
    }
}