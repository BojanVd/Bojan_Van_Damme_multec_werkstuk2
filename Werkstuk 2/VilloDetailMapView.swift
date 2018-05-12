//
//  VilloDetailMapView.swift
//  Werkstuk 2
//
//  Created by Stan Van Damme on 12/05/2018.
//  Copyright © 2018 BojanVanDamme. All rights reserved.
//

import UIKit

protocol VilloDetailMapViewDelegate: class { // 1
    func detailsRequestedForVillo(villoStation: VilloStation)
}

class VilloDetailMapView: UIView {
    // outlets
    @IBOutlet weak var StationName: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var StationAddress: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var StationStatus: UILabel!
    @IBOutlet weak var StandsLabel: UILabel!
    @IBOutlet weak var StationStands: UILabel!
    @IBOutlet weak var BikesLabel: UILabel!
    @IBOutlet weak var StationBikes: UILabel!
    @IBOutlet weak var SeeDetailsBtn: UIButton!
    
    // data
    var villoStation: VilloStation!
    weak var delegate: VilloDetailMapViewDelegate?
    
    @IBAction func seeDetails(_ sender: Any) { // 4
        delegate?.detailsRequestedForVillo(villoStation: villoStation)
    }
    
    func configureWithVillo(villoStation: VilloStation) { // 5
        self.villoStation = villoStation
        
        let standsString = villoStation.availableStands
        let bikesString = villoStation.availableBikes
        
        StationName.text = villoStation.name
        StationAddress.text = villoStation.address
        StationStatus.text = villoStation.status
        StationStands.text = "\(standsString)"
        StationBikes.text = "\(bikesString)"
        
    }
}
