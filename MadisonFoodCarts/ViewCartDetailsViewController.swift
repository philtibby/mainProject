//
//  ViewCartDetailsViewController.swift
//  MadisonFoodCarts
//
//  Created by Carly Hildebrandt on 11/6/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit

class ViewCartDetailsViewController: UIViewController
{
    
    @IBOutlet weak var cartNameLabel: UILabel!
    
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UITextView!
    
    /*var cartName: String?
    
    var cuisineType: String?
    
    var ownerMessage: String?*/
    
    var thisCart: FoodCart?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*cartNameLabel.text = cartName
        cuisineTypeLabel.text = cuisineType
        messageLabel.text = ownerMessage*/
        
        cartNameLabel.text = thisCart!.cartName
        cuisineTypeLabel.text = thisCart!.cuisineType
        messageLabel.text = thisCart!.message
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if (segue.identifier == "editDetails")
        {
            let svc = segue.destinationViewController as! EditCartInfoViewController
            
            svc.thisCart = thisCart
            
        }
        else if (segue.identifier == "viewMenu")
        {
            let svc = segue.destinationViewController as! CartMenuListTableViewController
            
            svc.thisCart = thisCart
        
        }
        else if (segue.identifier == "openCart")
        {
            let svc = segue.destinationViewController as! OpenCartViewController
            
            svc.thisCart = thisCart
        }
    }
}















