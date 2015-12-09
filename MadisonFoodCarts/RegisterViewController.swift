//
//  RegisterViewController.swift
//  MadisonFoodCarts
//
//  Created by Carly Hildebrandt on 12/8/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password1: UITextField!
    
    @IBOutlet weak var password2: UITextField!
    
    @IBOutlet weak var errorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
    {
        if (identifier == "justRegistered") {
            var alreadyExists = false
            let query = PFQuery(className:"Operator")
            
            
            query.whereKeyExists("username")
            query.findObjectsInBackgroundWithBlock
                {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                        // Do something with the found objects
                        
                        if let objects = objects as [PFObject]!
                        {
                            for object in objects
                            {
                                if (self.username.text == (object["username"] as! String))
                                {
                                self.errorMsg.text = "username already exists"
                                alreadyExists = true
                                }
                            }
                        }
            
                }
            if (alreadyExists == true) {
                return false
            }
    
            
            
        // passwords don't match
        if (password1.text != password2.text) {
            errorMsg.text = "Passwords don't match"
            return false
        }
        if (password1.text!.characters.count < 8 || username.text!.characters.count < 6) {
            errorMsg.text = "Username should be greater than 6 characters, passwords greater than 8"
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
        let svc = segue.destinationViewController as! LoginViewController
        
        // User just registered, save their information and pop back o login, have them login
        if (segue.identifier == "justRegistered")
        {
            print("register")
            
            
            let newOperator = PFObject(className:"Operator")
            newOperator["username"] = username.text
            newOperator["password"] = password1.text
            do
            {
                try newOperator.save()
                print("new operator created")
                svc.username.text = self.username.text
                svc.password.text = self.password1.text
            }
                
            catch
            {
                print("Error occured saving operator")
            }
            
            
            
            
        }
        else if (segue.identifier == "alreadyHasAccount")
        {
            print("account already")
        }
        else {
            print("error in segues")
        }
        
        
    }
    

}
