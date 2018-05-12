//
//  VilloStation.swift
//  Werkstuk 2
//
//  Created by Stan Van Damme on 12/05/2018.
//  Copyright © 2018 BojanVanDamme. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

//Aanmaken VilloStation klasse

class VilloStation {
    var name: String
    var address: String
    var gps: CLLocationCoordinate2D
    var status: String
    var availableStands: Int
    var availableBikes: Int
    
    init(){
        name = ""
        address = ""
        gps = CLLocationCoordinate2D()
        status = ""
        availableStands = 0
        availableBikes = 0
    }
    
    init(name: String, address: String, gps: CLLocationCoordinate2D, status: String, availableStands: Int, availableBikes: Int) {
        self.name = name
        self.address = address
        self.gps = gps
        self.status = status
        self.availableStands = availableStands
        self.availableBikes = availableBikes
    }
}
