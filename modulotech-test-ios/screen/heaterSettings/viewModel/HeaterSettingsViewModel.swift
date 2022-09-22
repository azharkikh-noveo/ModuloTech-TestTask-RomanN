//
//  HeaterSettingsViewModel.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation
import Combine


// MARK: - View-model

/// View-model of the heater device settings screen.
public final class HeaterSettingsViewModel: BaseViewModel {
    
    
    /// Reference to a coordinator.
    private weak var coordinator: DeviceSettingsCoordinator?
    
    /// A device to display.
    public var device: Heater
    
    
    // MARK: Publishers
    
    /// Current heater mode.
    public let isHeaterOn: PassthroughSubject<Bool, Never> = .init()
    
    /// Current heater intensity.
    public let heaterTemperature: PassthroughSubject<Double, Never> = .init()
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of a view-model, assignes a coordinator and a device to it.
    public init(
        device: Heater,
        coordinator: DeviceSettingsCoordinator?
    ) {
        self.device = device
        self.coordinator = coordinator
    }
    
    
    /// Should be called once from a view-controller to setup a initial state.
    public func initialSetup() {
        self.isHeaterOn.send(device.mode.booleanValue)
        self.heaterTemperature.send(device.temperature)
    }
    
}


// MARK: Settings

extension HeaterSettingsViewModel {
    
    
    /// Changes the heater binary mode.
    public func setHeaterMode(isOn: Bool) {
        device.mode = BinaryMode(isOn: isOn)
        isHeaterOn.send(isOn)
    }
    
    /// Changes the heater temperature.
    public func setTemperature(_ temperature: Double) {
        device.set(temperature: temperature)
        heaterTemperature.send(device.temperature)
    }
    
}


// MARK: Navigation

extension HeaterSettingsViewModel {
    
    
    /// Closes the screen.
    public func close() {
        
        do {
            
            try coordinator?.changeState(
                from: .heaterSettings(device: device),
                to: .deviceList
            )
            
        } catch let error {
            
            print(error)
            
        }
        
    }
    
}
