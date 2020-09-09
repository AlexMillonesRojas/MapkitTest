//
//  MyAnnotation.swift
//  MapKitTest
//
//  Created by Edgar Alexander on 03/09/2020.
//  Copyright © 2020 Edgar Alexander. All rights reserved.
//

import MapKit

class MyAnnotation: NSObject, MKAnnotation
{
    var title: String?
    var locationName: String
    var discipline: String
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, cordinate:CLLocationCoordinate2D) {
        self.title = title
        self.discipline = discipline
        self.locationName = locationName
        self.coordinate = cordinate
        
        super.init()
    }
    
    var subtitle: String?
{
    return locationName
    }
}
