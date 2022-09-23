//
//  DeviceTypeName.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 22.09.2022.
//

import Foundation


/// The name of the deivce type.
public enum DeviceTypeName {
    
    
    /// Light device.
    case light
    
    /// Heater device.
    case heater
    
    /// Roller shutter.
    case rollerShutter
    
    
    /// String uppercased value.
    public var stringValue: String {
        switch self {
        case .light:
            return L10n.Device.Light.kind
        case .heater:
            return L10n.Device.Heater.kind
        case .rollerShutter:
            return L10n.Device.RollerShutter.kind
        }
    }
    
}
