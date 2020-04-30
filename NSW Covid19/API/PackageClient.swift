//
//  PackageClient.swift
//  DataNSW
//
//  Created by Jay Salvador on 21/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import CoreData

public protocol PackageClientProtocol {
    
    func getPackages(onCompletion: HttpCompletionClosure<PackageClient.PackageResponse>?)
    
    func fetchFromStorage() -> [Package]?
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

    public func fetchFromStorage() -> [Package]? {
        
        let managedObjectContext = self.persistentContainer?.viewContext
        
        let name = String(describing: Package.self)
        
        let fetchRequest = NSFetchRequest<Package>(entityName: name)
        
        do {
            
            let packages = try managedObjectContext?.fetch(fetchRequest)
            
            return packages?.filter { $0.name == Package.casesByLocationAndSource }
            
        }
        catch {
            
            return nil
        }
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
