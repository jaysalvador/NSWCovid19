//
//  DateFormatter.swift
//  DataNSW
//
//  Created by Jay Salvador on 21/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let dateAndTime: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return dateFormatter
    }()
    
    /// returns a formatter for `yyyyMMdd`
    public static let yearMonthDay: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyyMMdd"
        
        return dateFormatter
    }()
    
    /// returns a formatter for `yyyyMMdd`
    public static let dashedYearMonthDay: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
    }()
    
    /// returns a formatter for ISO8601 `yyyyMMdd'T'HHmmss,SSSZZZZZ`
    public static let iso8601WithComma: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss,SSSZZZZZ"
        
        return dateFormatter
    }()
    
    /// returns an API date format `HH:mm a dd MMM yyyy`
    public static let lastUpdated: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "HH:mm a dd MMM yyyy"
        
        return dateFormatter
    }()
    
    /// returns an API date format `dd/MM/yyyy HH:mm a`
    public static let displayDate: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
        
        return dateFormatter
    }()
}
