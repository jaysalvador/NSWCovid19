//
//  String.swift
//  DataNSW
//
//  Created by Jay Salvador on 21/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension String {
    
    /// Returns the date value of the String based on the formats determined from the API
    public func toDate() -> Date? {
        
        if let dateAndTime = DateFormatter.dateAndTime.date(from: self) {
            
            return dateAndTime
        }
        else if let yearMonthDayDate = DateFormatter.yearMonthDay.date(from: self) {
            
            return yearMonthDayDate
        }
        else if let fullIsoDate = DateFormatter.iso8601WithComma.date(from: self) {
            
            return fullIsoDate
        }
        else if let date = DateFormatter.dashedYearMonthDay.date(from: self) {
            
            return date
        }
        else if let altIsoDate = DateFormatter.lastUpdated.date(from: self) {
            
            return altIsoDate
        }
        
        return nil
    }
}
