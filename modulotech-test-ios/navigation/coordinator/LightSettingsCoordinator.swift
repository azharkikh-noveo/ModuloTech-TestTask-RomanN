//
//  LightSettingsCoordinator.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


// MARK: - Delegate

/// The delegate of a light device screen. Should be used in view-model.
public protocol LightSettingsCoordinatorDelegate: AnyObject {
    
    
    /// Asks a delegate to close the screen.
    func viewModelDidClose(_ viewModel: LightSettingsViewModel)
    
}


// MARK: - Coordinator

/// Coordinator for a light settings screen.
public final class LightSettingsCoordinator: Coordinator {
    
    
    /// Reference to the current navigation controller.
    private weak var navigationController: UINavigationController?
    
    /// The target device.
    private let device: Light
    
    /// Creates an instance of a device.
    public init(
        for device: Light,
        navigationController: UINavigationController?
    ) {
        self.device = device
        self.navigationController = navigationController
    }
 
    public func viewController() -> UIViewController {
        
        let viewModel = LightSettingsViewModel(
            device: device,
            coordinatorDelegate: self
        )
        
        return LightSettingsViewController(viewModel: viewModel)
        
    }
    
}


// MARK: LightSettingsCoordinatorDelegate

extension LightSettingsCoordinator: LightSettingsCoordinatorDelegate {
    
    
    public func viewModelDidClose(_ viewModel: LightSettingsViewModel) {
        navigationController?.popViewController(animated: true)
    }
    
}
