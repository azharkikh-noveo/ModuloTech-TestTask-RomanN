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
    
    
    // MARK: Helper
    
    /// Setter for the light intensity.
    public func set(intensity newValue: Int) {
        intensity = clamp(intensity, using: 0...100)
    }
    
}
