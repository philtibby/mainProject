//
//  EditCartInfoViewController.swift
//  MadisonFoodCarts
//
//  Created by Carly Hildebrandt on 11/6/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//
import Parse
import UIKit
// for camera
import MobileCoreServices

class EditCartInfoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    var thisCart: FoodCart?
    var ownerCarts: [String]?
    
    var initialCartName = ""
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var cartName: UITextField!
    
    @IBOutlet weak var cuisineType: UITextField!
    
    @IBOutlet weak var ownerMessage: UITextField!
    
    // image for cart
    @IBOutlet weak var cartImage: UIImageView!
    let imagePicker = UIImagePickerController()
    
    // choosing photo from photo library
    @IBAction func choosePicture(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        
        cartName.text = thisCart!.cartName
        cuisineType.text = thisCart!.cuisineType
        ownerMessage.text = thisCart!.message
        
        initialCartName = thisCart!.cartName!
        
        
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    // for choosing image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //stops the segue if someone tries to make a new cart with the same name as a current cart
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
    {
        if let ident = identifier
        {
            if ident == "editedCart"
            {
                //if they name a cart the same as one they already have
                if ((ownerCarts!.contains(cartName.text!)) == true)
                {
                    //but it isn't just the same one they already had as the name
                    if !(cartName.text! == initialCartName)
                    {
                        let name: String = cartName.text!
                        errorLabel.text = "\(name) is already in the list of carts!"
                        return false
                    }
                }
                print(cartName.text)
                print(cuisineType.text)
                print(ownerMessage.text)
                //if they forgert to fill out a field
                if (cartName.text == "" || cuisineType.text == "" || ownerMessage.text == "")
                {
                    errorLabel.text = ("Please fill out all fields")
                    return false
                }
            }
        }
        return true
    }

    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        let svc = segue.destinationViewController as! ViewCartDetailsViewController
       
        
        var query = PFQuery(className:"Cart")
        query.getObjectInBackgroundWithId(thisCart!.Id!) {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let object = object {
                object["CartName"] = self.cartName.text
                object["CuisineType"] = self.cuisineType.text
                object["Message"] = self.ownerMessage.text
                
                do
                {
                    try object.save()
                }
                catch
                {
                    print("Error: there is an error")
                }
                
            }
        }
        
        query = PFQuery(className:"MenuItems")
        query.whereKey("CartName", equalTo: thisCart!.cartName!)
        query.findObjectsInBackgroundWithBlock
            {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil
                {
                    // The find succeeded.
                    print("Successfully retrieved the cart who's menu must be updated.")
                    // Do something with the found objects
                    
                    if let objects = objects as [PFObject]!
                    {
                        for object in objects
                        {
                            object["CartName"] = self.cartName.text
                            object.saveInBackground()
                        }
                        print("Successfully updated the menu's cart name")
                    }
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
        
        let updatedFC = FoodCart(cartName: cartName.text!, cartOwner: thisCart!.cartOwner, cuisineType: cuisineType.text!, message: ownerMessage.text!, isOpen: thisCart!.isOpen)
        updatedFC.Id = thisCart!.Id
        
        svc.thisCart = updatedFC
        svc.ownerCarts = ownerCarts
    }
}


