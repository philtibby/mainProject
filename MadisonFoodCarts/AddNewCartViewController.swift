//
//  AddNewCartViewController.swift
//  MadisonFoodCarts
//
//  Created by Carly Hildebrandt on 11/6/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import Parse

class AddNewCartViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
    
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        let svc = segue.destinationViewController as! OwnerCartsTableViewController
        
        // Pass the selected object to the new view controller.
        
        /*let newFoodCart = PFObject(className:"Cart")
        newFoodCart["CartName"] = cartName.text
        newFoodCart["CartOwner"] = cartOwner
        newFoodCart["CuisineType"] = cuisineType.text
        newFoodCart["Message"] = ownerMessage.text*/
        
        /*
        let newFC = FoodCart(cartName: object["CartName"]! as! String, cartOwner: cartOwner!, cuisineType: cuisineType.text!, coordinate: CLLocationCoordinate2D(latitude: object["Loc"].latitude, longitude: object["Loc"].longitude), message: ownerMessage.text, isOpen: false)
        */
        
        

        //svc.theAddedCart = newFC
        svc.newCartCreated = 1;
        

    }
}




































