//
//  CartMenuItemDetailsViewController.swift
//  MadisonFoodCarts
//
//  Created by Carly Hildebrandt on 11/6/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit

class CartMenuItemDetailsViewController: UIViewController
{
    var thisCartName: String?
    
    var thisMenuItem: MenuItem?

    @IBOutlet weak var itemName: UITextField!
    
    @IBOutlet weak var itemDescription: UITextView!
    
    @IBOutlet weak var itemPrice: UITextField!
    
    
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
        /*
         //Get the new view controller
        let svc = segue.destinationViewController as! CartMenuListTableViewController
        
        // Pass the selected object to the new view controller.
        if (segue.identifier == "editedMenuItem")
        {
            
            thisMenuItem.name = itemName.text?
            thisMenuItem.info = itemDescription.text?
            thisMenuItem.price = itemPrice.text?
            
            
            svc.menuItems[IndexPath.row] = thisMenuItem
        }
*/
    }
}











