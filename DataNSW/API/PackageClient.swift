//
//  PackageClient.swift
//  DataNSW
//
//  Created by Jay Salvador on 21/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

protocol PackageClientProtocol {
    
    func getPackages(onCompletion: HttpCompletionClosure<PackageClient.PackageResponse>?)
}

public class PackageClient: HttpClient, PackageClientProtocol {
    
    public func getPackages(onCompletion: HttpCompletionClosure<PackageClient.PackageResponse>?) {
        
        let endpoint = "/package_search?q=covid"
        
        self.request(
            PackageClient.PackageResponse.self,
            endpoint: endpoint,
            httpMethod: .get,
            headers: nil,
            onCompletion: onCompletion
        )
    }
}

extension PackageClient {
    
    public struct PackageResponse: Decodable {
        
        public var packages: [Package]?
        
        enum CodingKeys: String, CodingKey {
            
            case result
            case results
        }
        
        /// Decoded override to bind all currencies into an array
        /// - Parameter decoder: `Decoder ` object
        public init(from decoder: Decoder) throws {
            
            let container = try decoder.container(keyedBy: CodingKeys.self)

            if let packageContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .result) {
                
                self.packages = try packageContainer.decodeIfPresent([Package].self, forKey: .results)
            }
        }
    }
}
