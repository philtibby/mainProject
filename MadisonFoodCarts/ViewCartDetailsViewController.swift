//
//  ViewCartDetailsViewController.swift
//  MadisonFoodCarts
//
//  Created by Carly Hildebrandt on 11/6/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import MapKit
import Parse

class ViewCartDetailsViewController: UIViewController, CLLocationManagerDelegate
{
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var activateLabel: UILabel!
    
    @IBOutlet weak var activateCart: UISwitch!
    
    @IBOutlet weak var cartNameLabel: UILabel!
    
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UITextView!
    
    var thisCart: FoodCart?
    var ownerCarts: [String]?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        activateCart.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        cartNameLabel.text = thisCart!.cartName
        cuisineTypeLabel.text = thisCart!.cuisineType
        messageLabel.text = thisCart!.message
        
        print(thisCart!.isOpen);
        
        if (thisCart!.isOpen) {
            activateCart.setOn(true, animated: true);
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func stateChanged(switchState: UISwitch)
    {
        if (switchState.on)
        {
            activateLabel.text = "Deactivate Cart:"
            thisCart!.isOpen = true
            
            // Ask for Authorisation from the User.
            self.locationManager.requestAlwaysAuthorization()
            
            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startMonitoringSignificantLocationChanges()
            }
        }
        else
        {
            activateLabel.text = "Activate Cart:"
            thisCart!.isOpen = false
            
            let query = PFQuery(className:"Cart")
            query.getObjectInBackgroundWithId(thisCart!.Id!) {
                (theCart: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let theCart = theCart {
                    theCart["Loc"] = NSNull();
                    theCart["isOpen"] = false
                    theCart.saveInBackground()
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        if (thisCart!.isOpen) {
            let query = PFQuery(className:"Cart")
            query.getObjectInBackgroundWithId(thisCart!.Id!) {
                (theCart: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let theCart = theCart {
                    let point = PFGeoPoint(latitude:locValue.latitude, longitude:locValue.longitude)
                    theCart["Loc"] = point;
                    theCart["isOpen"] = true
                    theCart.saveInBackground()
                }
            }
        }
    
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        
        if (segue.identifier == "editDetails")
        {
            let svc = segue.destinationViewController as! EditCartInfoViewController
            
            svc.thisCart = thisCart
            svc.thisCart!.Id = thisCart!.Id
            
        }
        else if (segue.identifier == "viewMenu")
        {
            let svc = segue.destinationViewController as! CartMenuListTableViewController
            
            svc.thisCartName = thisCart!.cartName!
        }
    }
}















