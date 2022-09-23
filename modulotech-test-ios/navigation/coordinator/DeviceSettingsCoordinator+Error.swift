//
//  DeviceSettingsCoordinator+Error.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 22.09.2022.
//

import Foundation


extension DeviceSettingsCoordinator {
    
    
    /// Errors of the coordinator.
    public enum DeviceSettingsCoordinatorError: Error {
        
        
        /// The coordinator cannot change between states.
        case cannotChangeState
        
    }
    
}
