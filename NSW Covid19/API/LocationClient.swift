//
//  LocationClient.swift
//  DataNSW
//
//  Created by Jay Salvador on 21/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public protocol LocationClientProtocol {
    
    func getPatients(id: String?, offset: Int?, onCompletion: HttpCompletionClosure<LocationClient.LocationResponse>?)
}

public class LocationClient: HttpClient, LocationClientProtocol {
    
    public func getPatients(id: String?, offset: Int?, onCompletion: HttpCompletionClosure<LocationClient.LocationResponse>?) {
        
        let request = LocationClient.LocationRequest(id: id, offset: offset)
        
        let endpoint = "/datastore_search\(request.parameters)"
        
        self.request(
            LocationClient.LocationResponse.self,
            endpoint: endpoint,
            httpMethod: .get,
            headers: nil,
            onCompletion: onCompletion
        )
    }
}

extension LocationClient {
    
    public struct LocationRequest: Encodable {
        
        public var id: String?
        public var offset: Int?
        
        var parameters: String {
            
            return UrlParameters()
                    .with(key: CodingKeys.id, value: self.id)
                    .with(key: CodingKeys.offset, value: self.offset)
                    .flattened
        }
        
        enum CodingKeys: String, CodingKey {
            
            case id
            case offset
        }
    }
    
    public struct LocationResponse: Decodable {
        
        public var total: Int?
        public var locations: [Location]?
        
        enum CodingKeys: String, CodingKey {
            
            case result
            case records
            case total
        }
        
        /// Decoded override to bind all currencies into an array
        /// - Parameter decoder: `Decoder ` object
        public init(from decoder: Decoder) throws {
            
            let container = try decoder.container(keyedBy: CodingKeys.self)

            if let packageContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .result) {
                
                self.total = try packageContainer.decodeIfPresent(Int.self, forKey: .total)
                self.locations = try packageContainer.decodeIfPresent([Location].self, forKey: .records)
            }
        }
    }
}
