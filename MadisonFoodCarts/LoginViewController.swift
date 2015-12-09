//
//  LoginViewController.swift
//  MadisonFoodCarts
//
//  Created by Carly Hildebrandt on 12/8/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    var matchFound = false
    
    @IBOutlet weak var errMsg: UILabel!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButton(sender: AnyObject) {
      
        
    }
    
    
    
    
    // This action allows the register view controller to pop back to here
    @IBAction func exitToHere(segue: UIStoryboardSegue) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
    {
        
        if (identifier == "login") {
            let query = PFQuery(className:"Operator")
            query.whereKey("username", equalTo: username.text!)
            do {
                let objects = try query.findObjects()
                if let objects = objects as [PFObject]! {
                    for object in objects
                    {
                        print("password typed: ", self.password.text!)
                        if (self.password.text! == (object["password"] as! String)) {
                            print("match found")
                            self.matchFound = true
                            break
                        }
                    }
                }
                else {
                    print("something didint work!")
                }
            }
                
            catch {
                print("error in login occurred")
            }
            if (self.matchFound) {
                self.matchFound = false
                return true
            }
            else {
                errMsg.text = "Incorrect username or password"
                return false
            }
            
        }
        return true
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "login")
        {
            let svc = segue.destinationViewController as! OwnerCartsTableViewController
            svc.thisOwner = self.username.text!
            
        }
        
    }
    

}
