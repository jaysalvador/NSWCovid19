//
//  KeyedDecodingContainer.swift
//  DataNSW
//
//  Created by Jay Salvador on 21/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

/// extending `KeyedDecodingContainer` to handle decoding for dates and rate values

extension KeyedDecodingContainer {
    
    /// Decode dates aligned to formats thrown by the API
    /// - Parameter key: the `CodingKey` attribute name
    func dateIfPresent(forKey key: KeyedDecodingContainer.Key) -> Date? {
        
        guard let string = try? self.decodeIfPresent(String.self, forKey: key) else {
            
            return nil
        }
        
        return string.toDate()
    }
    
    func sourceTypeIfPresent(forKey key: KeyedDecodingContainer.Key) -> SourceType? {
        
        guard let string = try? self.decodeIfPresent(String.self, forKey: key) else {
            
            return nil
        }
        
        return SourceType(rawValue: string.lowercased())
    }
}
