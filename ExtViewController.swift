//
//  ExtViewController.swift
//  MadisonFoodCarts
//
//  Created by Philip Tibbetts on 10/19/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import Foundation
import MapKit
import Parse

extension ViewController: MKMapViewDelegate {
    
   
    
    // 1
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? FoodCartMap {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
                let button = UIButton(type: .System)
                button.frame = CGRectMake(100, 100, 100, 50)
                //button.backgroundColor = UIColor.()
                button.setTitle("Get Directions", forState: UIControlState.Normal)
                view.leftCalloutAccessoryView = button as UIView
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
            let location = view.annotation as! FoodCartMap
            if control == view.leftCalloutAccessoryView {
                let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                location.mapItem().openInMapsWithLaunchOptions(launchOptions)
            } else {
                zeCart = location
                performSegueWithIdentifier("MapToMenu", sender: nil)
            }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let svc = segue.destinationViewController as! CartInfoViewController
        svc.cart = zeCart!
    }

}