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
    
    @IBOutlet weak var itemInfo: UITextView!
    
    @IBOutlet weak var itemPrice: UITextField!
    
    var thisCartName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
        newMenuItem["Price"] = (itemPrice.text! as NSString).floatValue
        newMenuItem["Description"] = itemInfo.text
        
        do
        {
            try newMenuItem.save()
        }
            
        catch
        {
            print("Error occured")
        }
        
        let newMI = MenuItem(name: itemName.text!, cartName: thisCartName, price: (itemPrice.text! as NSString).floatValue, info: itemInfo.text!)
        
        svc.theAddedItem = newMI
        svc.thisCartName = thisCartName
    }
}
