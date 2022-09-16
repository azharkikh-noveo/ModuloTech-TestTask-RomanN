//
//  ShutterSettingsViewModel.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 16.09.2022.
//

import Foundation
import Combine


// MARK: - View-model

/// View-model of the shutter device settings screen.
public final class ShutterSettingsViewModel: BaseViewModel {
    
    
    /// Router type used by the view-model.
    public typealias RouterType = Router
    
    /// Assigned router.
    private let router: ShutterSettingsViewModel.RouterType
    
    /// A device to display.
    public let device: RollerShutter
    
    
    // MARK: Publishers
    
    /// Current shutter position.
    public let shutterPosition: PassthroughSubject<Int, Never> = .init()
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of a view-model, assignes a router and a device to it.
    public init(
        router: ShutterSettingsViewModel.RouterType,
        device: RollerShutter
    ) {
        self.router = router
        self.device = device
    }
    
    public override func onViewDidLoad() {
        super.onViewDidLoad()
        self.shutterPosition.send(device.position)
    }
    
}


// MARK: Settings

extension ShutterSettingsViewModel {
    
    
    /// Changes the shutter position.
    public func setPosition(_ position: Int) {
        device.set(position: position)
        shutterPosition.send(device.position)
    }
    
}


// MARK: Navigation

extension ShutterSettingsViewModel {
    
    
    /// Closes the screen.
    public func close() {
        router.close(completion: nil)
    }
    
}

