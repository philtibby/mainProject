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
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
        
        if (identifier == "login")
        {
            let query = PFQuery(className:"Operator")
            query.whereKey("username", equalTo: username.text!)
            do
            {
                let objects = try query.findObjects()
                if let objects = objects as [PFObject]!
                {
                    for object in objects
                    {
                        print("password typed: ", self.password.text!)
                        if (self.password.text! == (object["password"] as! String))
                        {
                            print("match found")
                            self.matchFound = true
                            break
                        }
                    }
                }
                else
                {
                    print("something didint work!")
                }
            }
            catch
            {
                print("error in login occurred")
            }
            if (self.matchFound)
            {
                self.matchFound = false
                return true
            }
            else
            {
                let alertController = UIAlertController(title: "Incorrect username or password!", message: "Please try again.", preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // ...
                }
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
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
            
            let navVC = segue.destinationViewController as! UINavigationController
            
            let homeVC = navVC.viewControllers.first as! HomePageViewController

            homeVC.ownerName = self.username.text!
            
        }
        
    }
    

}
