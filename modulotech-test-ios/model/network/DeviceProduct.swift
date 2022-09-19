//
//  DeviceProduct.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation


/// Device raw model used for decoding.
public struct DeviceProduct {
    
    
    /// Every device has this parameter.
    public let deviceId: Int
    
    /// Every device has this parameter.
    public let name: String
    
    /// Every device has this parameter.
    public let productType: DeviceProduct.ProductType
    
    /// Not every device has this parameter.
    public let temperature: Double?
    
    /// Not every device has this parameter.
    public let position: Int?
    
    /// Not every device has this parameter.
    public let intensity: Int?
    
    /// Not every device has this parameter.
    public let mode: DeviceProduct.Mode?
    
}


// MARK: Decodable

extension DeviceProduct: Decodable {
    
    
    private enum CodingKeys: String, CodingKey {
        case deviceId = "id"
        case name = "deviceName"
        case temperature = "temperature"
        case position = "position"
        case intensity = "intensity"
        case mode = "mode"
        case productType = "productType"
    }
    
}
