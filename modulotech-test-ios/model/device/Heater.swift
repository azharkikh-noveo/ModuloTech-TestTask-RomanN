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
    
    
    /// Default heater temperature lowerbound.
    public static let defaultMinimumTemperature: Double = 7.0
    
    /// Default heater temperature upperbound.
    public static let defaultMaximumTemperature: Double = 28.0
    
    
    public var deviceType: DeviceTypeName {
        return .heater
    }
    
    public var deviceId: Int
    
    public var name: String
    
    /// Heater mode.
    public var mode: BinaryMode
    
    /// Minimum temperature.
    public let minimumTemperature: Double
    
    /// Heater temperature
    public private(set) var temperature: Double
    
    /// Maximum temperature.
    public let maximumTemperature: Double
    
    /// The heater temperature change step.
    public let temperatureStep: Double = 0.5
    
    
    // MARK: Init
    
    /// Creates an instace of the light device with all parameters specified.
    ///
    /// If the provided minimum temperature is greater than the maximum one, they are swapped.
    public init(
        deviceId: Int,
        name: String,
        mode: BinaryMode,
        temperature: Double,
        minimumTemperature: Double = Heater.defaultMinimumTemperature,
        maximumTemperature: Double = Heater.defaultMaximumTemperature
    ) {
        self.deviceId = deviceId
        self.name = name
        self.mode = mode
        self.minimumTemperature = min(minimumTemperature, maximumTemperature)
        self.maximumTemperature = max(minimumTemperature, maximumTemperature)
        self.temperature = clamp(
            temperature,
            using: self.minimumTemperature...self.maximumTemperature
        )
    }
    
    /// Creates an instance of the device from its raw model if possible.
    ///
    /// Sets the default minimum and maximum temperature.
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
        self.minimumTemperature = Heater.defaultMinimumTemperature
        self.maximumTemperature = Heater.defaultMaximumTemperature
        
    }
    
    
    // MARK: Helper
    
    /// Setter for the heater temperature.
    public mutating func set(temperature newValue: Double) {
        temperature = clamp(newValue, using: minimumTemperature...maximumTemperature)
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
