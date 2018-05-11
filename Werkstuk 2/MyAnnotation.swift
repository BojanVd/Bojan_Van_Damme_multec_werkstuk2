//
//  MyAnnotation.swift
//  Werkstuk 2
//
//  Created by Stan Van Damme on 11/05/2018.
//  Copyright © 2018 BojanVanDamme. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    override init() {
        coordinate = CLLocationCoordinate2D()
        title = ""
    }
    
    init (coordinate:CLLocationCoordinate2D, title:String)
    {
        self.coordinate = coordinate
        self.title = title
        
    }
}
