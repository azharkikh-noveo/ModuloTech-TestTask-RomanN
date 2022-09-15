//
//  LightSettingsViewModel.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import Foundation
import Combine


// MARK: - View-model

/// View-model of the light device settings screen.
public final class LightSettingsViewModel: BaseViewModel {
    
    
    /// Router type used by the view-model.
    public typealias RouterType = Router
    
    /// Assigned router.
    private let router: LightSettingsViewModel.RouterType
    
    /// Publishes devices to display.
    public let device: Light
    
    
    // MARK: Publishers
    
    /// Current light mode.
    public let isLightOn: PassthroughSubject<Bool, Never> = .init()
    
    /// Current light intensity.
    public let lightIntensity: PassthroughSubject<Int, Never> = .init()
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of a view-model and assignes a router to it.
    public init(
        router: DeviceListViewModel.RouterType,
        device: Light
    ) {
        self.router = router
        self.device = device
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
        device.mode = Device.BinaryMode(isOn: isOn)
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
        router.close(completion: nil)
    }
    
}
