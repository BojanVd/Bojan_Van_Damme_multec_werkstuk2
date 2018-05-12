//
//  AnnotationView.swift
//  Werkstuk 2
//
//  Created by Stan Van Damme on 12/05/2018.
//  Copyright © 2018 BojanVanDamme. All rights reserved.
//  https://digitalleaves.com/blog/2016/12/building-the-perfect-ios-map-ii-completely-custom-annotation-views/

import UIKit
import MapKit

private let kVilloMapAnimationTime = 0.300

class AnnotationView: MKAnnotationView {
    // data
    weak var villoDetailDelegate: VilloDetailMapViewDelegate?
    weak var customCalloutView: VilloDetailMapView?
    override var annotation: MKAnnotation? {
        willSet { customCalloutView?.removeFromSuperview() }
    }
    
    // MARK: - life cycle
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = false // 1
        //self.image = kPersonMapPinImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false // 1
        //self.image = kPersonMapPinImage
    }
    
    // MARK: - callout showing and hiding
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected { // 2
            self.customCalloutView?.removeFromSuperview() // remove old custom callout (if any)
            
            if let newCustomCalloutView = loadVilloDetailMapView() {
                // fix location from top-left to its right place.
                newCustomCalloutView.frame.origin.x -= newCustomCalloutView.frame.width / 2.0 - (self.frame.width / 2.0)
                newCustomCalloutView.frame.origin.y -= newCustomCalloutView.frame.height
                
                // set custom callout view
                self.addSubview(newCustomCalloutView)
                self.customCalloutView = newCustomCalloutView
                
                // animate presentation
                if animated {
                    self.customCalloutView!.alpha = 0.0
                    UIView.animate(withDuration: kVilloMapAnimationTime, animations: {
                        self.customCalloutView!.alpha = 1.0
                    })
                }
            }
        } else { // 3
            if customCalloutView != nil {
                if animated { // fade out animation, then remove it.
                    UIView.animate(withDuration: kVilloMapAnimationTime, animations: {
                        self.customCalloutView!.alpha = 0.0
                    }, completion: { (success) in
                        self.customCalloutView!.removeFromSuperview()
                    })
                } else { self.customCalloutView!.removeFromSuperview() } // just remove it.
            }
        }
    }
    
    func loadVilloDetailMapView() -> VilloDetailMapView? {
        if let views = Bundle.main.loadNibNamed("VilloDetailMapView", owner: self, options: nil) as? [VilloDetailMapView], views.count > 0 {
            let villoDetailMapView = views.first!
            villoDetailMapView.delegate = self.villoDetailDelegate
            if let villoAnnotation = annotation as? MyAnnotation {
                let villo = villoAnnotation.villo
                villoDetailMapView.configureWithVillo(villoStation: villo)
            }
            return villoDetailMapView
        }
        return nil
    }
    
    override func prepareForReuse() { // 5
        super.prepareForReuse()
        self.customCalloutView?.removeFromSuperview()
    }
}

