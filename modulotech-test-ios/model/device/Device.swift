//
//  Device.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation


// MARK: Device

/// Base type of a smart home devices.
public protocol Device: CustomStringConvertible {
    
    
    /// Device identifier.
    var deviceId: Int { get set }
    
    /// Device name.
    var name: String { get set }
    
    /// Device type string.
    var deviceType: DeviceTypeName { get }
    
}
