//
//  RollerShutterSettingsViewModel.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation
import Combine


// MARK: - View-model

/// View-model of the shutter device settings screen.
public final class RollerShutterSettingsViewModel: BaseViewModel {
    
    
    /// Reference to a coordinator.
    private weak var coordinator: DeviceSettingsCoordinator?
    
    /// A device to display.
    public var device: RollerShutter
    
    
    // MARK: Publishers
    
    /// Current shutter position.
    public let shutterPosition: PassthroughSubject<Int, Never> = .init()
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of a view-model, assignes a coordinator and a device to it.
    public init(
        device: RollerShutter,
        coordinator: DeviceSettingsCoordinator?
    ) {
        self.device = device
        self.coordinator = coordinator
    }
    
    
    /// Should be called once from a view-controller to setup a initial state.
    public func initialSetup() {
        self.shutterPosition.send(device.position)
    }
    
}


// MARK: Settings

extension RollerShutterSettingsViewModel {
    
    
    /// Changes the shutter position.
    public func setPosition(_ position: Int) {
        device.set(position: position)
        shutterPosition.send(device.position)
    }
    
}


// MARK: Navigation

extension RollerShutterSettingsViewModel {
    
    
    /// Closes the screen.
    public func close() {
        
        do {
            
            try coordinator?.changeState(
                from: .rollerShutterSettings(device: device),
                to: .deviceList
            )
            
        } catch let error {
            
            print(error)
            
        }
        
    }
    
}
