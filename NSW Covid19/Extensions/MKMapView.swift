//
//  MKMapView.swift
//  NSW Covid19
//
//  Created by Jay Salvador on 21/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import MapKit

extension MKMapView {
    
    func centerMap(on coordinate: CLLocationCoordinate2D, radius: CLLocationDistance = 2000, animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        
        if animated {
            
            if completion == nil {
                
                self.setRegion(coordinateRegion, animated: true)
            }
            else {
                
                MKMapView.animate(
                    withDuration: 0.175,
                    animations: { [weak self] in
                        
                        self?.region = coordinateRegion
                    },
                    completion: completion
                )
            }
        }
        else {
            
            self.setRegion(coordinateRegion, animated: false)
        }
    }
}
