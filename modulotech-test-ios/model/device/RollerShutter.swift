//
//  RollerShutter.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import Foundation


/// "RollerShutter" device.
public final class RollerShutter: Device {
    
    
    /// Shutter position
    public private(set) var position: Int
    
    /// Creates an instace of the roller shutter device with all parameters specified.
    public init(
        deviceId: Int,
        name: String,
        position: Int
    ) {
        self.position = clamp(position, using: 0...100)
        super.init(id: deviceId, name: name)
    }
    
    
    // MARK: Helper
    
    /// Setter for the shutter position.
    public func set(position newValue: Int) {
        position = clamp(newValue, using: 0...100)
    }
    
}
