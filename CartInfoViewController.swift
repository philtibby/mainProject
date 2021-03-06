//
//  CartInfoViewController.swift
//  MadisonFoodCarts
//
//  Created by Matt Peterson on 11/1/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit

class CartInfoViewController: UIViewController {
    
    var cart : FoodCartMap?
    
    
    @IBOutlet weak var nameOutlet: UILabel!
    
    @IBOutlet weak var typeOutlet: UILabel!
    
    //@IBOutlet weak var messageOutlet: UITextView!
    @IBOutlet weak var messageOutlet: UITextView!
    
    let beige = UIColor(red: 255/255, green: 245/255, blue: 178/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
    
        nameOutlet.text = cart!.cartName
        typeOutlet.text = cart!.cuisineType
        messageOutlet.text = cart!.message
        messageOutlet.textColor = beige
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let svc = segue.destinationViewController as! MenuTableViewController
        svc.cart = self.cart!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
