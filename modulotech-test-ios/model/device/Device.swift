//
//  Device.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation


// MARK: Device

/// Base class for smart home device.
public class Device: CustomStringConvertible {
    
    
    public var description: String {
        return "Device(id: \(deviceId), name: \"\(name)\")"
    }
    
    
    /// A device type string.
    public var deviceType: String {
        return L10n.Device.Device.kind
    }
    
    
    /// Device identifier.
    public var deviceId: Int
    
    /// Device name.
    public var name: String
    
    /// Creates an instance of a device.
    public init(id: Int, name: String) {
        self.deviceId = id
        self.name = name
    }
    
}
