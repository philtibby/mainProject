//
//  ViewController.swift
//  MadisonFoodCarts
//
//  Created by Philip Tibbetts on 10/13/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import MapKit
import Parse

class ViewController: UIViewController, CLLocationManagerDelegate
{
    var locationManager: CLLocationManager!

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*let testObject = PFObject(className: "Cart")
        let point = PFGeoPoint(latitude:43.07345, longitude:-89.39234)
        testObject["Loc"] = point;
        testObject["CartOwner"] = "Phil";
        
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }*/
        
        mapView.delegate = self;
        mapView.showsUserLocation = true;
        
        let initialLocation = CLLocation(latitude: 43.074911, longitude: -89.3986841);
        centerMapOnLocation(initialLocation);
        
        
        /*let cart = FoodCart(title: "Fake Cart",
            locationName: "poop",
            discipline: "Food Cart",
            cuisineType: "Chinese",
            coordinate: CLLocationCoordinate2D(latitude: 43.074911, longitude: -89.3986841))
        
        mapView.addAnnotation(cart);
        
        let cart2 = FoodCart(title: "Fake Cart",
            locationName: "poop",
            discipline: "Food Cart",
            cuisineType: "Chinese",
            coordinate: CLLocationCoordinate2D(latitude: 43.0741, longitude: -89.341))
        
        mapView.addAnnotation(cart2);*/
        
        var cart : FoodCartMap?;
        
        let query = PFQuery(className:"Cart")
        //query.whereKey("playerName", equalTo:"Sean Plott")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                // Do something with the found objects
                if let objects = objects as [PFObject]! {
                    for object in objects {
                        //print(object["Loc"]!.latitude)
                        cart = FoodCartMap(cartName: object["CartName"]! as! String,
                            cartOwner: "Philipine",
                            //locationName: "poop",
                            //discipline: "Food Cart",
                            cuisineType: "Chinese",
                            coordinate: CLLocationCoordinate2D(latitude: object["Loc"].latitude, longitude: object["Loc"].longitude),
                            message: "This is my message to you oo oo",
                            isOpen: false)
                        
                        self.mapView.addAnnotation(cart!);
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters
            locationManager.distanceFilter = 10
        }
        
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    /*override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let location = locations.last as CLLocation!
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
    }
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
}

