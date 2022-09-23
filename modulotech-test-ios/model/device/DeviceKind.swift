//
//  DeviceKind.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 22.09.2022.
//

import Foundation


/// Wrapper of a device into an enum.
public enum DeviceKind {
    
    
    // MARK: Cases
    
    /// The light device.
    case light(Light)
    
    /// The heater device.
    case heater(Heater)
    
    /// The roller shutter device.
    case rollerShutter(RollerShutter)
    
    
    // MARK: Init
    
    /// Creates an instance from a raw product.
    public init?(rawModel product: DeviceProduct) {
        
        var deviceKind: DeviceKind?
        
        switch product.productType {
        case .heater:
            deviceKind = Heater.init(from: product).flatMap(Self.init(from:))
        case .light:
            deviceKind = Light.init(from: product).flatMap(Self.init(from:))
        case .rollerShutter:
            deviceKind = RollerShutter.init(from: product).flatMap(Self.init(from:))
        }
        
        guard let deviceKind = deviceKind else {
            return nil
        }
        
        self = deviceKind
        
    }
    
    /// Creates an instance from a specific device.
    public init(from device: Light) {
        self = .light(device)
    }
    
    /// Creates an instance from a specific device.
    public init(from device: Heater) {
        self = .heater(device)
    }
    
    /// Creates an instance from a specific device.
    public init(from device: RollerShutter) {
        self = .rollerShutter(device)
    }
    
    
    // MARK: Getters
    
    /// A type-erased device.
    public var device: Device {
        switch self {
        case .light(let light):
            return light
        case .heater(let heater):
            return heater
        case .rollerShutter(let rollerShutter):
            return rollerShutter
        }
    }
    
}
