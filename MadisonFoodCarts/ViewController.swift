//
//  ViewController.swift
//  MadisonFoodCarts
//
//  Created by Philip Tibbetts on 10/13/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 43.074911, longitude: -89.3986841);
        centerMapOnLocation(initialLocation);
        
        
        let cart = FoodCart(title: "Fake Cart",
            locationName: "",
            discipline: "Food Cart",
            coordinate: CLLocationCoordinate2D(latitude: 43.074911, longitude: -89.3986841))
        
        mapView.addAnnotation(cart)
        
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
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
}

