//
//  AgeGroup.swift
//  DataNSW
//
//  Created by Jay Salvador on 31/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public enum AgeType: String, Codable {
    
    case group04 = "AgeGroup_0-4"
    case group59 = "AgeGroup_5-9"
    case group1014 = "AgeGroup_10-14"
    case group1519 = "AgeGroup_15-19"
    case group2024 = "AgeGroup_20-24"
    case group2529 = "AgeGroup_25-29"
    case group3034 = "AgeGroup_30-34"
    case group3539 = "AgeGroup_35-39"
    case group4044 = "AgeGroup_40-44"
    case group4549 = "AgeGroup_45-49"
    case group5054 = "AgeGroup_50-54"
    case group5559 = "AgeGroup_55-59"
    case group6064 = "AgeGroup_60-64"
    case group6569 = "AgeGroup_65-69"
    case group70 = "AgeGroup_70+"
}

public struct AgeGroup: Codable {
    
    public var id: Int?
    public var notificationDate: Date?
    public var ageGroup: AgeType?
}
