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
    let cartName: String?
    let cartOwner: String
    //let locationName: String
    //let discipline: String
    let cuisineType: String
    let coordinate: CLLocationCoordinate2D
    let message: String
    var isOpen: Bool
    
    
    
    
    init(cartName: String, cartOwner: String,/*locationName: String*/ /*discipline: String,*/ cuisineType: String, coordinate: CLLocationCoordinate2D, message: String, isOpen: Bool)
    {
        self.cartName = cartName
        self.cartOwner = cartOwner
        //self.locationName = locationName
        //self.discipline = discipline
        self.coordinate = coordinate
        self.cuisineType = cuisineType
        self.message = message
        self.isOpen = isOpen
        
        super.init()
    }
    
    var subtitle: String?
    {
        return cuisineType
    }
    
    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem
    {
        let addressDictionary = [String(CNPostalAddressStreetKey): self.subtitle!]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.cartName
        
        return mapItem
    }
    
}


class MenuItem: NSObject
{
    let name: String
    let cartName: String
    let price: Float
    let info: String
    
    init(name: String, cartName: String, price: Float, info: String)
    {
        self.name = name
        self.cartName = cartName
        self.price = price
        self.info = info
    }
}








