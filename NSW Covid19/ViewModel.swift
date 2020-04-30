//
//  ViewModel.swift
//  NSW Covid19
//
//  Created by Jay Salvador on 21/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import MapKit

typealias ViewModelCallback = (() -> Void)

protocol ViewModelProtocol {
    
    // MARK: - Data
    
    var locations: [Location]? { get }
    
    var geocodes: [Int: CLLocation]? { get }
    
    var counts: [Int: Int]? { get }
    
    var total: Int? { get }
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback? { get set }
    
    var onGeolocationUpdated: ViewModelCallback? { get set }
    
    var onError: ViewModelCallback? { get set }
    
    // MARK: - Functions
    
    func loadLocations()
}

class ViewModel: ViewModelProtocol {
    
    // MARK: - Dependencies
    
    private var locationClient: LocationClientProtocol?
    
    private var packageClient: PackageClientProtocol?
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback?
    
    var onGeolocationUpdated: ViewModelCallback?
    
    var onError: ViewModelCallback?
    
    // MARK: - Data
    
    private(set) var locations: [Location]?
    
    private(set) var total: Int?
    
    private(set) var geocodes: [Int: CLLocation]?
    
    private(set) var counts: [Int: Int]?
    
    // MARK: - Init
    
    convenience init() {
        
        self.init(
            locationClient: LocationClient(persistentContainer: AppDelegate.shared?.persistentContainer),
            packageClient: PackageClient(persistentContainer: AppDelegate.shared?.persistentContainer)
        )
    }
    
    init(locationClient _locationClient: LocationClientProtocol?, packageClient _packageClient: PackageClientProtocol?) {
        
        self.locationClient = _locationClient
        
        self.packageClient = _packageClient
        
        self.geocodes = [Int: CLLocation]()
    }
    
    // MARK: - Functions
    
    func loadLocations() {
        
        self.locations = [Location]()
        
        if let package = self.packageClient?.fetchFromStorage(),
            let id = package.first?.id {

            self.getLocations(id: id, offset: nil)
        }
        else {
                    
            self.packageClient?.getPackages { [weak self] (response) in
    
                switch response {
                case .success(let result):
                    let package = result.packages?.filter { $0.name == Package.casesByLocationAndSource }
    
                    if let id = package?.first?.id {
    
                        self?.getLocations(id: id, offset: nil)
                    }
    
                case .failure:
    
                    self?.onError?()
                }
            }
        }
    }
    
    func getLocations(id: String, offset: Int?) {
        
        self.locationClient?.getPatients(id: id, offset: offset) { [weak self] (response) in
            
            switch response {
            case .success(let result):
                
                let total = result.total ?? 0
                
                let locations = result.locations ?? []
                
                self?.total = total
                
                self?.locations?.append(contentsOf: locations)
                
                if (self?.locations?.count ?? 0) < total {
                    
                    self?.getLocations(id: id, offset: self?.locations?.count)
                }
                else {
                    
                    if let postcodes = self?.locations?.filter({ ($0.postcode ?? 0) >= 2000 && ($0.postcode ?? 0) < 3000 }).compactMap({ $0.postcode }) {

                        self?.counts = postcodes.sorted { $0 < $1 }.reduce(into: [:]) { counts, postcode in counts[postcode, default: 0] += 1 }
                        
                        self?.getGeocodes(postcodes: Array(Set(postcodes)))
                    }
                }
                
            case .failure:
                
                self?.onError?()
            }
            
        }
    }
    
    func getGeocodes(postcodes: [Int]) {
        
        let sortedPostcodes = postcodes.sorted { $0 < $1 }
        
        self.getGeocode(
            postcodes: sortedPostcodes,
            inProgress: { [weak self] _ in

                self?.onGeolocationUpdated?()
            },
            completion: { [weak self] in

                self?.onUpdated?()
            }
        )
    }
    
    func getGeocode(postcodes: [Int], inProgress: ((Int) -> Void)? = nil, completion: (() -> Void)? = nil) {
        
        var _postcodes = postcodes
        
        guard _postcodes.count > 0, let postcode = _postcodes.first else {
            
            completion?()
            
            return
        }
        
        CLGeocoder().geocodeAddressString("NSW \(postcode)") { [weak self] (placemarks, error) in
          
            if let location = placemarks?.first?.location {
                
                _postcodes.removeFirst()

                self?.geocodes?[postcode] = location
                
                self?.getGeocode(postcodes: _postcodes, inProgress: inProgress, completion: completion)
            }
            
            if let error = error {
                
                if error.localizedDescription.lowercased().contains("error 2") {

                    print("NSW \(postcode): \(Date()) - " + error.localizedDescription)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 60) {

                        self?.getGeocode(postcodes: _postcodes, inProgress: inProgress, completion: completion)
                    }
                }
                else {
                    
                    _postcodes.removeFirst()

                    self?.getGeocode(postcodes: _postcodes, inProgress: inProgress, completion: completion)
                }
            }
            
            inProgress?(postcode)
        }
    }
}
