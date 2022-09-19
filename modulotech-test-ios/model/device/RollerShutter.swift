//
//  RollerShutter.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation


// MARK: - Model

/// "RollerShutter" device.
public struct RollerShutter: Device {
    
    
    public var deviceKindString: String {
        return L10n.Device.RollerShutter.kind
    }
    
    public var deviceId: Int
    
    public var name: String
    
    /// Shutter position
    public private(set) var position: Int
    
    /// Creates an instace of the roller shutter device with all parameters specified.
    public init(
        deviceId: Int,
        name: String,
        position: Int
    ) {
        self.deviceId = deviceId
        self.name = name
        self.position = clamp(position, using: 0...100)
    }
    
    /// Creates an instance of the device from its raw model if possible.
    public init?(from rawModel: DeviceProduct) {
        
        guard let position = rawModel.position else {
            return nil
        }
        
        self.deviceId = rawModel.deviceId
        self.name = rawModel.name
        self.position = position
        
    }
    
    
    // MARK: Helper
    
    /// Setter for the shutter position.
    public mutating func set(position newValue: Int) {
        position = clamp(newValue, using: 0...100)
    }
    
}


// MARK: CustomStringConvertible

extension RollerShutter: CustomStringConvertible {
    
    
    public var description: String {
        var result: String = ""
        result += "RollerShutter(id: \(deviceId), "
        result += "name: \"\(name)\", "
        result += "position: \(position))"
        return result
    }
    
}
