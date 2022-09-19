//
//  RollerShutterSettingsCoordinator.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


// MARK: - Delegate

/// The delegate of a shutter device settings screen. Should be used in view-model.
public protocol RollerShutterSettingsCoordinatorDelegate: AnyObject {
    
    
    /// Asks a delegate to close the screen.
    func viewModelDidClose(_ viewModel: RollerShutterSettingsViewModel)
    
}


// MARK: - Coordinator

/// Coordinator for a roller shutter settings screen.
public final class RollerShutterSettingsCoordinator: Coordinator {
    
    
    /// Reference to the current navigation controller.
    private weak var navigationController: UINavigationController?
    
    /// The target device.
    private let device: RollerShutter
    
    /// Creates an instance of a device.
    public init(
        for device: RollerShutter,
        navigationController: UINavigationController?
    ) {
        self.device = device
        self.navigationController = navigationController
    }
    
    public func viewController() -> UIViewController {
        
        let viewModel = RollerShutterSettingsViewModel(
            device: device,
            coordinatorDelegate: self
        )
        
        return RollerShutterSettingsViewController(viewModel: viewModel)
        
    }
    
}


// MARK: RollerShutterSettingsCoordinatorDelegate

extension RollerShutterSettingsCoordinator: RollerShutterSettingsCoordinatorDelegate {
    
    
    public func viewModelDidClose(_ viewModel: RollerShutterSettingsViewModel) {
        navigationController?.popViewController(animated: true)
    }
    
}
