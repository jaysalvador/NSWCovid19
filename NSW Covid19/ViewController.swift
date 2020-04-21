//
//  ViewController.swift
//  NSW Covid19
//
//  Created by Jay Salvador on 31/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import DataNSW
import MapKit
import LFHeatMap

class ViewController: UIViewController {
    
    @IBOutlet
    private var imageView: UIImageView?
    
    @IBOutlet
    private var mapView: MKMapView?
    
    // MARK: - View model
    
    private var viewModel: ViewModelProtocol? = ViewModel()
    
    // MARK: - Setup
    
    /// setup the ViewModel callbacks and their behaviours
    private func setupViewModel() {
        
        self.viewModel?.onUpdated = { [weak self] in

            print(self?.viewModel?.locations?.count ?? 0)
        }
        
        self.viewModel?.onGeolocationUpdated = { [weak self] in
            
            if let geocode = self?.viewModel?.geocodes?[2000] {
                
                self?.mapView?.centerMap(on: geocode.coordinate)
            }
        }
    }
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.setupViewModel()
        
        self.viewModel?.loadLocations()
    }

}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        if let geocodes = self.viewModel?.geocodes,
            let counts = self.viewModel?.counts {
            
            var locations = [CLLocation]()
            
            var weights = [Int]()
                        
            for postcode in geocodes.keys {
                
                if let weight = counts[postcode], let location = geocodes[postcode] {
                    
                    locations.append(location)

                    weights.append(weight)
                }
            }

            if locations.count > 0 {
            
                self.imageView?.image = LFHeatMap.heatMap(for: mapView, boost: Float(1), locations: locations, weights: weights)
            }
        }
    }
}
