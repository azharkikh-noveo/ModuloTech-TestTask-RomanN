//
//  DeviceProduct+Mode.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation


extension DeviceProduct {
    
    
    /// Raw device mode.
    public enum Mode: String, Decodable {
        
        case on = "ON"
        
        case off = "OFF"
        
    }
    
}
