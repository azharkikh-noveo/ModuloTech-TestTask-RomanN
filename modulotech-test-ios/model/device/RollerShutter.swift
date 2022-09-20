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
    
    
    /// Default roller shutter position lowerbound.
    public static let defaultMinimumPosition: Int = 0
    
    /// Default roller shutter position upperbound.
    public static let defaultMaximumPosition: Int = 100
    
    
    public var deviceKindString: String {
        return L10n.Device.RollerShutter.kind
    }
    
    public var deviceId: Int
    
    public var name: String
    
    /// Minimum shutter position.
    public let minimumPosition: Int
    
    /// Shutter position
    public private(set) var position: Int
    
    /// Maximum shutter position.
    public let maximumPosition: Int
    
    /// The shutter position change step.
    public let positionStep: Int = 1
    
    
    // MARK: Init
    
    /// Creates an instace of the roller shutter device with all parameters specified.
    ///
    /// If the provided minimum position is greater than the maximum one, they are swapped.
    public init(
        deviceId: Int,
        name: String,
        position: Int,
        minimumPosition: Int = RollerShutter.defaultMinimumPosition,
        maximumPosition: Int = RollerShutter.defaultMaximumPosition
    ) {
        self.deviceId = deviceId
        self.name = name
        self.minimumPosition = min(minimumPosition, maximumPosition)
        self.maximumPosition = max(minimumPosition, maximumPosition)
        self.position = clamp(position, using: self.minimumPosition...self.maximumPosition)
    }
    
    /// Creates an instance of the device from its raw model if possible.
    ///
    /// Sets the default minimum and maximum position.
    public init?(from rawModel: DeviceProduct) {
        
        guard let position = rawModel.position else {
            return nil
        }
        
        self.deviceId = rawModel.deviceId
        self.name = rawModel.name
        self.position = position
        self.minimumPosition = RollerShutter.defaultMinimumPosition
        self.maximumPosition = RollerShutter.defaultMaximumPosition
        
    }
    
    
    // MARK: Helper
    
    /// Setter for the shutter position.
    public mutating func set(position newValue: Int) {
        position = clamp(newValue, using: minimumPosition...maximumPosition)
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
