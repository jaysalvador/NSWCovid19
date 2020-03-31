//
//  Location.swift
//  DataNSW
//
//  Created by Jay Salvador on 31/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public struct Location: Codable {

    public var id: Int?
    public var notificationDate: Date?
    public var postcode: Int?
    public var lhd2010Code: String?
    public var lhd2010Name: String?
    public var lgaCode19: Int?
    public var lgaName19: String?

    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case notificationDate = "notification_date"
        case postcode
        case lhd2010Code = "lhd_2010_code"
        case lhd2010Name = "lhd_2010_name"
        case lgaCode19 = "lga_code19"
        case lgaName19 = "lga_name19"
    }
}
