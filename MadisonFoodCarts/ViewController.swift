//
//  ViewController.swift
//  MadisonFoodCarts
//
//  Created by Philip Tibbetts on 10/13/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.delegate = self;
        mapView.showsUserLocation = true;
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 43.074911, longitude: -89.3986841);
        centerMapOnLocation(initialLocation);
        
        
        let cart = FoodCart(title: "Fake Cart",
            locationName: "poop",
            discipline: "Food Cart",
            cuisineType: "Chinese",
            coordinate: CLLocationCoordinate2D(latitude: 43.074911, longitude: -89.3986841))
        
        mapView.addAnnotation(cart)
        
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
        let location = locations.last as CLLocation!
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        print("fuck");
        
        mapView.setRegion(region, animated: true)
    }
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
}

