//
//  DeviceProduct+ProductType.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation


extension DeviceProduct {
    
    
    /// Raw device product type.
    public enum ProductType: String, Decodable {
        
        case light = "Light"
        
        case heater = "Heater"
        
        case rollerShutter = "RollerShutter"
    
    }
    
}
