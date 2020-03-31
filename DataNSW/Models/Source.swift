//
//  Source.swift
//  DataNSW
//
//  Created by Jay Salvador on 31/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public enum SourceType: String, Codable {
    
    case overseas = "Overseas"
    case investigation = "Under Investigation"
    case unidentified = "Locally acquired - contact not identified"
    case local = "Locally acquired - contact of a confirmed case and/or in a known cluster"
}

public struct Source: Codable {
    
    public var id: Int?
    public var notificationDate: Date?
    public var source: SourceType?
}
