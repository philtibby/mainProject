//
//  AddNewCartViewController.swift
//  MadisonFoodCarts
//
//  Created by Carly Hildebrandt on 11/6/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import Parse

class AddNewCartViewController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    var locationManager: CLLocationManager!
    
    var cartOwner: String = ""
    
    
    @IBOutlet weak var cartName: UITextField!
    
    
    @IBOutlet weak var cuisineType: UITextField!
    
    
    @IBOutlet weak var ownerMessage: UITextView!
    
    //for choosing cart image
    @IBOutlet weak var cartImage: UIImageView!
    let imagePicker = UIImagePickerController()
   
    @IBAction func choosePicture(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
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
            if ident == "addedOperator"
            {
                /*if (operatorList!.contains(operatorName.text!)) == true
                {
                    let name: String = operatorName.text!
                    errorLabel.text = "\(name) is already in the list of operators! Please try again!"
                    return false
                }*/
            }
        }
        return true
    }
    
    
    // MARK: - Navigation

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
        
        newFoodCart.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
        
        // create a new FoodCart object
        let newFC = FoodCart(cartName: cartName.text!, cartOwner: cartOwner, cuisineType: cuisineType.text!, message: ownerMessage.text, isOpen: false)

        // add it to the list of owner's food carts
        svc.theAddedCart = newFC
        svc.newCartCreated = 1;
    }
}


























