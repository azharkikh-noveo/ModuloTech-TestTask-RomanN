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
    
    
    /// Coordinator delegate.
    private weak var coordinatorDelegate: RollerShutterSettingsCoordinatorDelegate?
    
    /// A device to display.
    public var device: RollerShutter
    
    
    // MARK: Publishers
    
    /// Current shutter position.
    public let shutterPosition: PassthroughSubject<Int, Never> = .init()
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of a view-model, assignes a coordinator and a device to it.
    public init(
        device: RollerShutter,
        coordinatorDelegate: RollerShutterSettingsCoordinatorDelegate?
    ) {
        self.device = device
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    
    public override func onViewDidLoad() {
        super.onViewDidLoad()
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
        coordinatorDelegate?.viewModelDidClose(self)
    }
    
}
