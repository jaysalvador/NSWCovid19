//
//  Source.swift
//  DataNSW
//
//  Created by Jay Salvador on 31/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public enum SourceType: String, Codable {
    
    case overseas = "overseas"
    case investigation = "under investigation"
    case unidentified = "locally acquired - contact not identified"
    case local = "locally acquired - contact of a confirmed case and/or in a known cluster"
    case interstate = "interstate"
}

public struct Source: Codable {
    
    public var id: Int?
    public var notificationDate: Date?
    public var source: SourceType?
}
