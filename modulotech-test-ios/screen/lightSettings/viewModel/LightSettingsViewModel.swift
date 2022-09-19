//
//  LightSettingsViewModel.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation
import Combine


// MARK: - View-model

/// View-model of the light device settings screen.
public final class LightSettingsViewModel: BaseViewModel {
    
    
    /// Coordinator delegate.
    private weak var coordinatorDelegate: LightSettingsCoordinatorDelegate?
    
    /// A device to display.
    public let device: Light
    
    
    // MARK: Publishers
    
    /// Current light mode.
    public let isLightOn: PassthroughSubject<Bool, Never> = .init()
    
    /// Current light intensity.
    public let lightIntensity: PassthroughSubject<Int, Never> = .init()
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of a view-model, assignes a coordinator and a device to it.
    public init(
        device: Light,
        coordinatorDelegate: LightSettingsCoordinatorDelegate?
    ) {
        self.device = device
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    public override func onViewDidLoad() {
        super.onViewDidLoad()
        self.isLightOn.send(device.mode.booleanValue)
        self.lightIntensity.send(device.intensity)
    }
    
}


// MARK: Settings

extension LightSettingsViewModel {
    
    
    /// Changes the light binary mode.
    public func setLightMode(isOn: Bool) {
        device.mode = BinaryMode(isOn: isOn)
        isLightOn.send(isOn)
    }
    
    /// Changes the light intensity level.
    public func setIntensity(_ instensity: Int) {
        device.set(intensity: instensity)
        lightIntensity.send(device.intensity)
    }
    
}


// MARK: Navigation

extension LightSettingsViewModel {
    
    
    /// Closes the screen.
    public func close() {
        coordinatorDelegate?.viewModelDidClose(self)
    }
    
}
