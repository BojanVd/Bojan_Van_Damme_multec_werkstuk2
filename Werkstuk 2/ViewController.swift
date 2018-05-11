//
//  ViewController.swift
//  Werkstuk 2
//
//  Created by Stan Van Damme on 10/05/2018.
//  Copyright © 2018 BojanVanDamme. All rights reserved.
//
// Bronnen:
// https://api.jcdecaux.com/vls/v1/stations?apiKey=6d5071ed0d0b3b68462ad73df43fd9e5479b03d6&contract=Bruxelles-Capitale
// https://medium.com/ios-os-x-development/real-world-example-fetch-json-using-nsurlsession-and-populate-a-uitableview-3e5d84c87e68

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var MijnMap: MKMapView!
    
    var nameStation: Array <String> = Array <String>()
    var addressStation: Array <String> = Array <String>()
    var coorLat: Array <Double> = Array <Double>()
    var coorLng: Array <Double> = Array <Double>()
    var status: Array <String> = Array <String>()
    var availableStands: Array <Int> = Array <Int>()
    var availableBikes: Array <Int> = Array <Int>()
    
    override func viewDidLoad() {
        
        //self.myLabel.text = NSLocalizedString("Hello world!", comment: "")
        MijnMap.showsUserLocation = true
        MijnMap.delegate = self
        
        super.viewDidLoad()
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
            
            guard let jsonData = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [AnyObject] else {
                print("Not containing JSON")
                return
            }
            
            guard let dataVillo = jsonData as? NSArray else {
                return
            }
            
            if let stationsVillo = jsonData as? NSArray {
                for i in 0 ..< dataVillo.count{
                    if let objVillo = stationsVillo[i] as? NSDictionary {
                        if let posVillo = objVillo["position"] as? AnyObject {
                            self.coorLat.append(Double(posVillo["lat"] as! NSNumber))
                            self.coorLng.append(Double(posVillo["lng"] as! NSNumber))
                        }
                        if let nameVillo = objVillo["name"] as? AnyObject {
                            self.nameStation.append(String(nameVillo as! NSString))
                        }
                        if let addressVillo = objVillo["address"] as? AnyObject {
                            self.addressStation.append(String(addressVillo as! NSString))
                        }
                    }
                    
                    let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: self.coorLat[i], longitude: self.coorLng[i])
                    let annotation:MyAnnotation = MyAnnotation(coordinate: coordinate, title: self.nameStation[i])
                    self.MijnMap.addAnnotation(annotation)
                    
                }
            }
            
            
            //print(self.nameStation)
            
            DispatchQueue.main.async {
                //self.tableView.reloadData()
            }
        }
        
        task.resume()
        
        /*let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 50.843781, longitude: 4.323419)
        let coordinateTwo:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 50.840549, longitude: 4.319514)
        
        let annotation:MyAnnotation = MyAnnotation(coordinate: coordinate, title: "De Eerste")
        let annotationTwo:MyAnnotation = MyAnnotation(coordinate: coordinateTwo, title: "De Tweede")
        
        self.MijnMap.addAnnotation(annotation)
        self.MijnMap.addAnnotation(annotationTwo)*/
        self.MijnMap.showAnnotations(self.MijnMap.annotations, animated: true)
        
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

