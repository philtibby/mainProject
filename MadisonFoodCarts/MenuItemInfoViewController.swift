//
//  MenuItemInfoViewController.swift
//  MadisonFoodCarts
//
//  Created by Matt Peterson on 11/1/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit

class MenuItemInfoViewController: UIViewController
{

    var currentItem: MenuItem?
        
    @IBOutlet weak var itemInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //obtain menu item info and set it as the label
        
        let info = currentItem!.info
        itemInfo.text = info
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
