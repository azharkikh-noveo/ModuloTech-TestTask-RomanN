//
//  BinaryMode.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation


/// A simple device mode. Can be either on or off.
public enum BinaryMode: UInt8, CustomStringConvertible {
    
    
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
    
    /// Whether a mode is *on*.
    public var booleanValue: Bool {
        return (self == .on)
    }
    
    public var description: String {
        switch self {
        case .off:
            return L10n.Device.BinaryMode.off
        case .on:
            return L10n.Device.BinaryMode.on
        }
    }
    
}
