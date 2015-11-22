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
    
    @IBOutlet weak var activateLabel: UILabel!
    
    @IBOutlet weak var activateCart: UISwitch!
    
    @IBOutlet weak var cartNameLabel: UILabel!
    
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UITextView!
    
    var thisCart: FoodCart?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        activateCart.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        cartNameLabel.text = thisCart!.cartName
        cuisineTypeLabel.text = thisCart!.cuisineType
        messageLabel.text = thisCart!.message
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func stateChanged(switchState: UISwitch)
    {
        if (switchState.on)
        {
            activateLabel.text = "Deactivate Cart:"
            thisCart!.isOpen = true
        }
        else
        {
            activateLabel.text = "Activate Cart:"
            thisCart!.isOpen = false
        }
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
    }
}















