//
//  Heater.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation


// MARK: - Model

/// "Heater" device.
public struct Heater: Device {
    
    
    public var deviceKindString: String {
        return L10n.Device.Heater.kind
    }
    
    public var deviceId: Int
    
    public var name: String
    
    /// Heater mode.
    public var mode: BinaryMode
    
    /// Heater temperature
    public private(set) var temperature: Double
    
    /// Creates an instace of the light device with all parameters specified.
    public init(
        deviceId: Int,
        name: String,
        mode: BinaryMode,
        temperature: Double
    ) {
        self.deviceId = deviceId
        self.name = name
        self.mode = mode
        self.temperature = clamp(temperature, using: 7...28)
    }
    
    /// Creates an instance of the device from its raw model if possible.
    public init?(from rawModel: DeviceProduct) {
        
        guard
            let mode = rawModel.mode.flatMap(BinaryMode.init(rawMode:)),
            let temperature = rawModel.temperature
        else {
            return nil
        }
        
        self.deviceId = rawModel.deviceId
        self.name = rawModel.name
        self.temperature = temperature
        self.mode = mode
        
    }
    
    
    // MARK: Helper
    
    /// Setter for the heater temperature.
    public mutating func set(temperature newValue: Double) {
        temperature = clamp(newValue, using: 7...28)
    }
    
}


// MARK: CustomStringConvertible

extension Heater: CustomStringConvertible {
    
    
    public var description: String {
        var result: String = ""
        result += "Heater(id: \(deviceId), "
        result += "name: \"\(name)\", "
        result += "temperature: \(temperature), "
        result += "mode: \"\(mode)\")"
        return result
    }
    
}
