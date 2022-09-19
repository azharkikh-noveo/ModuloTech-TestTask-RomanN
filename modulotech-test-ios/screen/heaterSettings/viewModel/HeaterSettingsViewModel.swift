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
    
    
    /// Coordinator delegate.
    private weak var coordinatorDelegate: HeaterSettingsCoordinatorDelegate?
    
    /// A device to display.
    public let device: Heater
    
    
    // MARK: Publishers
    
    /// Current heater mode.
    public let isHeaterOn: PassthroughSubject<Bool, Never> = .init()
    
    /// Current heater intensity.
    public let heaterTemperature: PassthroughSubject<Double, Never> = .init()
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of a view-model, assignes a coordinator and a device to it.
    public init(
        device: Heater,
        coordinatorDelegate: HeaterSettingsCoordinatorDelegate?
    ) {
        self.device = device
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    public override func onViewDidLoad() {
        super.onViewDidLoad()
        self.isHeaterOn.send(device.mode.booleanValue)
        self.heaterTemperature.send(device.temperature)
    }
    
}


// MARK: Settings

extension HeaterSettingsViewModel {
    
    
    /// Changes the heater binary mode.
    public func setHeaterMode(isOn: Bool) {
        device.mode = Device.BinaryMode(isOn: isOn)
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
        coordinatorDelegate?.viewModelDidClose(self)
    }
    
}
