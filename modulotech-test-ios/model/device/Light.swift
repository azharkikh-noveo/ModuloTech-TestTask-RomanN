//
//  Light.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation


// MARK: - Model

/// "Light" device.
public struct Light: Device {
    
    
    /// Default light intensity lowerbound.
    public static let defaultMinimumIntensity: Int = 0
    
    /// Default light intensity upperbound.
    public static let defaultMaximumIntensity: Int = 100
    
    
    public var deviceKindString: String {
        return L10n.Device.Light.kind
    }
    
    public var deviceId: Int
    
    public var name: String
    
    /// Light mode.
    public var mode: BinaryMode
    
    /// Minimum light intensity.
    public let minimumIntensity: Int
    
    /// Light intensity. Use `set(intensity:)` to change the value.
    public private(set) var intensity: Int
    
    /// Maximum light intensity.
    public let maximumIntensity: Int
    
    /// The intensity change step.
    public let intensityStep: Int = 1
    
    
    // MARK: Init
    
    /// Creates an instace of the light device with all parameters specified.
    public init(
        deviceId: Int,
        name: String,
        mode: BinaryMode,
        intensity: Int,
        minimumIntensity: Int = Light.defaultMinimumIntensity,
        maximumIntensity: Int = Light.defaultMaximumIntensity
    ) {
        self.deviceId = deviceId
        self.name = name
        self.intensity = clamp(intensity, using: minimumIntensity...maximumIntensity)
        self.mode = mode
        self.minimumIntensity = minimumIntensity
        self.maximumIntensity = maximumIntensity
    }
    
    /// Creates an instance of the device from its raw model if possible.
    public init?(from rawModel: DeviceProduct) {
        
        guard
            let mode = rawModel.mode.flatMap(BinaryMode.init(rawMode:)),
            let intensity = rawModel.intensity
        else {
            return nil
        }
        
        self.deviceId = rawModel.deviceId
        self.name = rawModel.name
        self.intensity = intensity
        self.mode = mode
        self.minimumIntensity = Light.defaultMinimumIntensity
        self.maximumIntensity = Light.defaultMaximumIntensity
        
    }
    
    
    // MARK: Helper
    
    /// Setter for the light intensity.
    public mutating func set(intensity newValue: Int) {
        intensity = clamp(newValue, using: minimumIntensity...maximumIntensity)
    }
    
}


// MARK: CustomStringConvertible

extension Light: CustomStringConvertible {
    
    
    public var description: String {
        var result: String = ""
        result += "Light(id: \(deviceId), "
        result += "name: \"\(name)\", "
        result += "intensity: \(intensity), "
        result += "mode: \"\(mode)\")"
        return result
    }
    
}
