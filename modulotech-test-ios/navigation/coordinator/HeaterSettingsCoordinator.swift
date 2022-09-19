//
//  HeaterSettingsCoordinator.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


// MARK: - Delegate

/// The delegate of a heater device settings screen. Should be used in view-model.
public protocol HeaterSettingsCoordinatorDelegate: AnyObject {
    
    
    /// Asks a delegate to close the screen.
    func viewModelDidClose(_ viewModel: HeaterSettingsViewModel)
    
}


// MARK: - Coordinator

public final class HeaterSettingsCoordinator: Coordinator {
    
    /// Reference to the current navigation controller.
    private weak var navigationController: UINavigationController?
    
    /// The target device.
    private let device: Heater
    
    /// Creates an instance of a device.
    public init(
        for device: Heater,
        navigationController: UINavigationController?
    ) {
        self.device = device
        self.navigationController = navigationController
    }
    
    public func viewController() -> UIViewController {
        
        let viewModel = HeaterSettingsViewModel(
            device: device,
            coordinatorDelegate: self
        )
        
        return HeaterSettingsViewController(viewModel: viewModel)
        
    }
    
}


// MARK: HeaterSettingsCoordinatorDelegate

extension HeaterSettingsCoordinator: HeaterSettingsCoordinatorDelegate {
    
    
    public func viewModelDidClose(_ viewModel: HeaterSettingsViewModel) {
        navigationController?.popViewController(animated: true)
    }
    
}
