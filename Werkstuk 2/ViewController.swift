//
//  ViewController.swift
//  Werkstuk 2
//
//  Created by Stan Van Damme on 10/05/2018.
//  Copyright © 2018 BojanVanDamme. All rights reserved.
// https://api.jcdecaux.com/vls/v1/stations?apiKey=6d5071ed0d0b3b68462ad73df43fd9e5479b03d6&contract=Bruxelles-Capitale

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()
    
    var viloArray = [String] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        func parseJSON() {
            let urlRequest = URL(string: "https://api.jcdecaux.com/vls/v1/stations?apiKey=6d5071ed0d0b3b68462ad73df43fd9e5479b03d6&contract=Bruxelles-Capitale")
            
            let task = URLSession.shared.dataTask(with: urlRequest!) {(data, response, error ) in
                
                guard error == nil else {
                    print("returning error")
                    return
                }
                
                guard let content = data else {
                    print("not returning data")
                    return
                }
                
                guard let jsonData = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                    print("Not containing JSON")
                    return
                }
                
                if let array = jsonData["companies"] as? [String] {
                    self.viloArray = array
                }
                
                print(self.viloArray)
                
                DispatchQueue.main.async {
                    //self.tableView.reloadData()
                }
            }
            task.resume()
        }
        
        //parseJSON()
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
    }
}

