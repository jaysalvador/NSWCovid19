//
//  Package.swift
//  DataNSW
//
//  Created by Jay Salvador on 17/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import CoreData

public class Package: NSManagedObject, Codable {
    
    public static let casesByLocationAndSource: String = "nsw-covid-19-cases-by-location-and-likely-source-of-infection"
    
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case resources
    }
    
    /// Decoded override to bind all currencies into an array
    /// - Parameter decoder: `Decoder ` object
    required public convenience init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Package", in: managedObjectContext) else {
                
            fatalError("Failed to decode Package")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decodeIfPresent(String.self, forKey: .name)

        if var resourcesContainer = try? container.nestedUnkeyedContainer(forKey: .resources) {
            
            while !resourcesContainer.isAtEnd {
                
                if let resourceContainer = try? resourcesContainer.nestedContainer(keyedBy: CodingKeys.self),
                    let id = try? resourceContainer.decodeIfPresent(String.self, forKey: .id) {
                    
                    self.id = id
                }
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        
    }
    
}
