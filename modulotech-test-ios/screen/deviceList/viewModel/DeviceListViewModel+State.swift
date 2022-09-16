//
//  DeviceListViewModel+State.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 16.09.2022.
//

import Foundation


extension DeviceListViewModel {
    
    
    /// Device list screen state.
    public enum State {
        
        
        /// The screen shows loading state.
        case loading
        
        /// The screen shows error state.
        case error(Error)
        
        /// The screen shows the device list.
        case deviceList
        
    }
    
}
