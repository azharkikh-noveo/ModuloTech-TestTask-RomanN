//
//  Light.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import Foundation


/// "Light" device.
public final class Light: Device {
    
    
    /// Light mode.
    public var mode: Device.BinaryMode
    
    /// Light intensity. Use `set(intensity:)` to change the value.
    public private(set) var intensity: Int
    
    /// Creates an instace of the light device with all parameters specified.
    public init(
        deviceId: Int,
        name: String,
        mode: Device.BinaryMode,
        intensity: Int
    ) {
        self.mode = mode
        self.intensity = clamp(intensity, using: 0...100)
        super.init(id: deviceId, name: name)
    }
    
    /// Creates an instance of the device from its raw model if possible.
    public init?(from rawModel: DeviceProduct) {
        
        guard
            let mode = rawModel.mode.flatMap(Device.BinaryMode.init(rawMode:)),
            let intensity = rawModel.intensity
        else {
            return nil
        }
        
        self.intensity = intensity
        self.mode = mode
        super.init(id: rawModel.deviceId, name: rawModel.name)
        
    }
    
    
    // MARK: Helper
    
    /// Setter for the light intensity.
    public func set(intensity newValue: Int) {
        intensity = clamp(intensity, using: 0...100)
    }
    
}
