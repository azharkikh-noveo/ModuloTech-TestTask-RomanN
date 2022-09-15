//
//  Device.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import Foundation


// MARK: Device

/// Base class for smart home device.
public class Device {
    
    
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


// MARK: Mode

extension Device {
    
    
    /// A simple device mode. Can be either on or off.
    public enum BinaryMode: UInt8 {
        
        /// ON.
        case on
        
        /// OFF.
        case off
        
        /// Creates an instance from the boolean value.
        public init(isOn: Bool) {
            self = isOn ? .on : .off
        }
        
        /// Creates an instance using raw value.
        public init?(rawMode: DeviceProduct.Mode) {
            switch rawMode {
            case .on:
                self = .on
            case .off:
                self = .off
            }
        }
        
    }
    
}
