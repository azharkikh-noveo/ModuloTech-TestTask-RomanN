//
//  DeviceListResponse.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import Foundation


/// Raw response for the device list request.
public struct DeviceListResponse: Decodable {
    
    
    /// List of raw device models.
    public let devices: Array<DeviceProduct>
    
}
