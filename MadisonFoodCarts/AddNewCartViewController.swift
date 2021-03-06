//
//  AddNewCartViewController.swift
//  MadisonFoodCarts
//
//  Created by Carly Hildebrandt on 11/6/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import Parse

class AddNewCartViewController: UIViewController /*UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate*/
{
    var locationManager: CLLocationManager!
    
    var ownerCarts: [String]?
    
    var cartOwner: String = ""
    
    @IBOutlet weak var cartName: UITextField!
    
    @IBOutlet weak var cuisineType: UITextField!
    
    @IBOutlet weak var ownerMessage: UITextView!
    
    @IBAction func messageCenterInfo(sender: AnyObject)
    {
        
        let alertController = UIAlertController(title: "Message Center", message: "This is where you can add your website link, phone number, hours of operation, or other relevant cart information you want potential customers to see.", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }
    
    //for choosing cart image
    /*@IBOutlet weak var cartImage: UIImageView!
    let imagePicker = UIImagePickerController()
   
    @IBAction func choosePicture(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imagePicker.delegate = self

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // for choosing image
    /*func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            cartImage.contentMode = .ScaleAspectFit
            cartImage.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                message: "Failed to save image",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                completion: nil)
        }
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //stops the segue if someone tries to make a new cart with the same name as a current cart
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
    {
        var cartNameTaken = false
        
        let query = PFQuery(className:"Cart")
        do {
            let objects = try query.findObjects()
            if let objects = objects as [PFObject]!
            {
                for object in objects
                {
                    if (self.cartName.text == (object["CartName"] as! String))
                    {
                        cartNameTaken = true
                        break
                    }
                }
            }
            else
            {
                print("Something didn't work!")
            }
            
        }
        catch
        {
            print("Error occurred!")
        }
        //if they name a cart the same as one they already have
        if (cartNameTaken)
        {
            let name: String = cartName.text!
            let alertController = UIAlertController(title: "A cart named \(name) already exists!", message: "Please choose a different cart name.", preferredStyle: .Alert)
                    
                    
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // ...
            }
            alertController.addAction(OKAction)
                    
            self.presentViewController(alertController, animated: true) {
                        // ...
            }
            return false
        }
        
        //if they forgert to fill out a field
        if (cartName.text == "" || cuisineType.text == "" || ownerMessage.text == "")
        {
                let alertController = UIAlertController(title: "Oops!", message: "Please fill out all fields.", preferredStyle: .Alert)
                    
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        // ...
            }
            alertController.addAction(OKAction)
                    
            self.presentViewController(alertController, animated: true) {
                        // ...
            }
            return false
        }
    return true
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        let svc = segue.destinationViewController as! OwnerCartsTableViewController
        
        // Pass the selected object to the new view controller.
        
       let newFoodCart = PFObject(className:"Cart")
        newFoodCart["CartName"] = cartName.text
        newFoodCart["CartOwner"] = cartOwner
        newFoodCart["CuisineType"] = cuisineType.text
        newFoodCart["Message"] = ownerMessage.text
        newFoodCart["isOpen"] = false
        
        do
        {
            try newFoodCart.save()
        }
        
        catch
        {
            print("Error occured")
        }
        
        
        // create a new FoodCart object
        let newFC = FoodCart(cartName: cartName.text!, cartOwner: cartOwner, cuisineType: cuisineType.text!, message: ownerMessage.text!, isOpen: false)
        newFC.Id = newFoodCart.objectId

        // add it to the list of owner's food carts
        svc.theAddedCart = newFC
        svc.thisOwner = cartOwner
    }
}


























