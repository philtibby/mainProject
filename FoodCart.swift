//
//  FoodCart.swift
//  MadisonFoodCarts
//
//  Created by Philip Tibbetts on 10/18/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import Foundation


import MapKit
import AddressBook
import Contacts

class FoodCart: NSObject, MKAnnotation
{
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String?
    {
        return locationName
    }
    
    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem
    {
        let addressDictionary = [String(CNPostalAddressStreetKey): self.subtitle!]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title
        
        return mapItem
    }
    
}


class MenuItem: NSObject
{
    let name: String
    let price: Float
    let info: String
    
    init(name: String, price: Float, info: String)
    {
        self.name = name
        self.price = price
        self.info = info
    }
}








