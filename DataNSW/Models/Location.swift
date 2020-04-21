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
    public var source: SourceType?
    public var lhd2010Code: String?
    public var lhd2010Name: String?
    public var lgaCode19: Int?
    public var lgaName19: String?

    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case notificationDate = "notification_date"
        case postcode
        case source = "likely_source_of_infection"
        case lhd2010Code = "lhd_2010_code"
        case lhd2010Name = "lhd_2010_name"
        case lgaCode19 = "lga_code19"
        case lgaName19 = "lga_name19"
    }
    
    /// Decoded override to bind all currencies into an array
    /// - Parameter decoder: `Decoder ` object
    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.notificationDate = try container.decodeIfPresent(Date.self, forKey: .notificationDate)
        self.postcode = try container.decodeIfPresent(Int.self, forKey: .postcode)
        self.source = try container.decodeIfPresent(SourceType.self, forKey: .source)
        self.lhd2010Code = try container.decodeIfPresent(String.self, forKey: .lhd2010Code)
        self.lhd2010Name = try container.decodeIfPresent(String.self, forKey: .lhd2010Name)
        self.lgaCode19 = try container.decodeIfPresent(Int.self, forKey: .lgaCode19)
        self.lgaName19 = try container.decodeIfPresent(String.self, forKey: .lgaName19)
    }
}
