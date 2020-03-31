//
//  DispatchQueue.swift
//  DataNSW
//
//  Created by Jay Salvador on 31/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    /// Accessible variable for the Background Queue
    public class var background: DispatchQueue {
        
        return DispatchQueue.global(qos: .background)
    }
}
