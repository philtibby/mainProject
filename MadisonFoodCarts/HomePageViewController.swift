//
//  HomePageViewController.swift
//  MadisonFoodCarts
//
//  Created by Carly Hildebrandt on 12/12/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    var ownerName=""
   
    @IBOutlet weak var greeting: UILabel!
   // presentViewController(controller, animated: true, completion: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greeting.text = "Hello " + ownerName + "!"
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

        if (segue.identifier == "viewCarts")
        {
            let svc = segue.destinationViewController as! OwnerCartsTableViewController
            svc.thisOwner = self.ownerName
        }
        if (segue.identifier == "accountInfo")
        {
            let svc = segue.destinationViewController as! AccountInfoViewController
            svc.ownerName = self.ownerName
        }
    }
}
