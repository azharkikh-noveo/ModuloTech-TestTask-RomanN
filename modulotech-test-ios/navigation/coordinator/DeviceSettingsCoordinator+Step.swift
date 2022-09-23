//
//  DeviceSettingsCoordinator+Step.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation


extension DeviceSettingsCoordinator {
    
    
    /// Coordinator states.
    public enum State {
        
        
        /// Device list screen. The default state.
        case deviceList
        
        /// Device settings screen.
        case lightSettings(device: Light)
        
        /// Device settings screen.
        case heaterSettings(device: Heater)
        
        /// Device settings screen.
        case rollerShutterSettings(device: RollerShutter)
        
    }
    
}


// MARK: Equatable

extension DeviceSettingsCoordinator.State: Equatable {
    
    
    public static func == (
        lhs: DeviceSettingsCoordinator.State,
        rhs: DeviceSettingsCoordinator.State
    ) -> Bool {
        
        switch (lhs, rhs) {
        case (.deviceList, .deviceList):
            return true
        case (.lightSettings, .lightSettings):
            return true
        case (.heaterSettings, .heaterSettings):
            return true
        case (.rollerShutterSettings, .rollerShutterSettings):
            return true
        default:
            return false
        }
        
    }
    
}
