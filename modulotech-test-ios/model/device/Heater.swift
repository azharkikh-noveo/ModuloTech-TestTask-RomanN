//
//  Heater.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import Foundation


/// "Heater" device.
public final class Heater: Device {
    
    
    /// Heater mode.
    public var mode: Device.BinaryMode
    
    /// Heater temperature
    public private(set) var temperature: Double
    
    /// Creates an instace of the light device with all parameters specified.
    public init(
        deviceId: Int,
        name: String,
        mode: Device.BinaryMode,
        temperature: Double
    ) {
        self.mode = mode
        self.temperature = clamp(temperature, using: 7...28)
        super.init(id: deviceId, name: name)
    }
    
    
    // MARK: Helper
    
    /// Setter for the heater temperature.
    public func set(temperature newValue: Double) {
        temperature = clamp(newValue, using: 7...28)
    }
    
}
