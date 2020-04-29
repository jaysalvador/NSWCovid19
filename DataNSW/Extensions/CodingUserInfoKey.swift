//
//  CodingUserInfoKey.swift
//  DataNSW
//
//  Created by Jay Salvador on 24/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public extension CodingUserInfoKey {
    
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
