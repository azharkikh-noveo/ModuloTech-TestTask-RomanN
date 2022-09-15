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
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of a view-model and assignes a router to it.
    public init(
        router: DeviceListViewModel.RouterType,
        device: Light
    ) {
        self.router = router
        self.device = device
    }
    
}


// MARK: Navigation

extension LightSettingsViewModel {
    
    
    /// Closes the screen.
    public func close() {
        router.close(completion: nil)
    }
    
}
