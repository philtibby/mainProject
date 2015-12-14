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
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
    {
        if (identifier == "justRegistered")
        {
            var alreadyExists = false
            
            let query = PFQuery(className:"Operator")
            do {
                let objects = try query.findObjects()
                if let objects = objects as [PFObject]! {
                    for object in objects
                    {
                        if (self.username.text == (object["username"] as! String))
                        {
                            alreadyExists = true
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
                print("error occurred")
            }
            if (alreadyExists)
            {
                let alertController = UIAlertController(title: "Username already exists!", message: "Please pick a new one.", preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // ...
                }
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
                return false
            }

            
            // passwords don't match
            if (password1.text != password2.text)
            {
                let alertController = UIAlertController(title: "Oops!", message: "The passwords do not match.", preferredStyle: .Alert)
            
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // ...
                }
                alertController.addAction(OKAction)
            
                self.presentViewController(alertController, animated: true) {
                // ...
                }
                return false
            }
            // not at least 6 characters in username
            if (username.text!.characters.count < 6)
            {
                let alertController = UIAlertController(title: "Oops!", message: "Username must be at least 6 characters.", preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // ...
                }
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
                return false
            }
            // not at least 8 characters in password
            if (password1.text!.characters.count < 8)
            {
                let alertController = UIAlertController(title: "Oops!", message: "Password must be at least 8 characters.", preferredStyle: .Alert)
                
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
