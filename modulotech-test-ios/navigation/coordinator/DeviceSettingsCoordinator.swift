//
//  DeviceSettingsCoordinator.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


// MARK: - Delegate

/// Methods for reacting to a coordinator state change.
public protocol DeviceSettingsCoordinatorDelegate: AnyObject {
    
    
    /// Called whenever a coordinator will change its state.
    ///
    /// Cases:
    /// - A coordinator is on the device list and changes its state to the device settings. Then a device model is passed in the *newState*.
    /// - A coordinator is on the device settings screen and changes its state to the list. Then a *modified* device model is passed in the *oldState*.
    func coordinator(
        _ coordinator: DeviceSettingsCoordinator,
        willChangeStateFrom oldState: DeviceSettingsCoordinator.State,
        to newState: DeviceSettingsCoordinator.State
    )
    
    
    /// Called whenever a coordinator did change its state.
    ///
    /// Cases:
    /// - A coordinator is on the device list and changes its state to the device settings. Then a device model is passed in the *newState*.
    /// - A coordinator is on the device settings screen and changes its state to the list. Then a *modified* device model is passed in the *oldState*.
    func coordinator(
        _ coordinator: DeviceSettingsCoordinator,
        didChangeStateFrom oldState: DeviceSettingsCoordinator.State,
        to newState: DeviceSettingsCoordinator.State
    )
    
}

extension DeviceSettingsCoordinatorDelegate {
    
    
    public func coordinator(
        _ coordinator: DeviceSettingsCoordinator,
        willChangeStateFrom oldState: DeviceSettingsCoordinator.State,
        to newState: DeviceSettingsCoordinator.State
    ) {
        
    }
    
    public func coordinator(
        _ coordinator: DeviceSettingsCoordinator,
        didChangeStateFrom oldState: DeviceSettingsCoordinator.State,
        to newState: DeviceSettingsCoordinator.State
    ) {
        
    }
    
}


// MARK: - Coordinator

///
public final class DeviceSettingsCoordinator: Coordinator {
    
    
    /// Reference to navigation controller.
    public private(set) weak var navigationController: UINavigationController?
    
    /// Current coordinator state.
    public private(set) var state: DeviceSettingsCoordinator.State = .deviceList
    
    /// Object that responds to the coordinator state changes.
    private weak var delegate: DeviceSettingsCoordinatorDelegate?
    
    /// Netowork service used for backend calls.
    private let networkService: NetworkService
    
    
    /// Creates an instance of a coordinator.
    public init(
        navigationController: UINavigationController?,
        networkService: NetworkService
    ) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    /// Creates an instance of a coordinator. Call in the AppDelegate
    public convenience init(
        window: UIWindow,
        networkService: NetworkService
    ) {
        
        let navigationController = BaseNavigationController()
        navigationController.isNavigationBarHidden = true
        
        window.rootViewController = navigationController
        
        self.init(
            navigationController: navigationController,
            networkService: networkService
        )
        
    }
    
    
    public func start() {
        
        let viewModel = DeviceListViewModel(
            networkService: networkService,
            coordinator: self
        )

        delegate = viewModel
        
        let viewController = DeviceListViewController(
            viewModel: viewModel
        )
        
        navigationController?.setViewControllers([viewController], animated: true)
        
    }
    
}


// MARK: Navigation

extension DeviceSettingsCoordinator {
    
    
    /// Whether a coordinator can change state to a new one.
    public func canChangeState(
        from oldState: DeviceSettingsCoordinator.State,
        to newState: DeviceSettingsCoordinator.State
    ) -> Bool {
        switch oldState {
        case .deviceList:
            return !(newState == .deviceList)
        case .heaterSettings, .lightSettings, .rollerShutterSettings:
            return (newState == .deviceList)
        }
    }
    
    /// Changes state of a coordinator.
    public func changeState(to newState: DeviceSettingsCoordinator.State) throws {
        
        try changeState(from: state, to: newState)
        
    }
    
    /// Changes state of a coordinator.
    public func changeState(
        from oldState: DeviceSettingsCoordinator.State,
        to newState: DeviceSettingsCoordinator.State
    ) throws {
        
        guard canChangeState(from: oldState, to: newState) else {
            throw NSError(domain: "DeviceSettingsCoordinator", code: -90)
        }
        
        delegate?.coordinator(self, willChangeStateFrom: oldState, to: newState)
        
        switch newState {
        case .deviceList:
        
            navigationController?.popViewController(animated: true)
            
        case .lightSettings(let device):
            
            let viewModel = LightSettingsViewModel(
                device: device,
                coordinator: self
            )
            
            let viewController = LightSettingsViewController(
                viewModel: viewModel
            )
            
            navigationController?.pushViewController(viewController, animated: true)
            
        case .heaterSettings(let device):
            
            let viewModel = HeaterSettingsViewModel(
                device: device,
                coordinator: self
            )
            
            let viewController = HeaterSettingsViewController(
                viewModel: viewModel
            )
            
            navigationController?.pushViewController(viewController, animated: true)
            
        case .rollerShutterSettings(let device):
            
            let viewModel = RollerShutterSettingsViewModel(
                device: device,
                coordinator: self
            )
            
            let viewController = RollerShutterSettingsViewController(
                viewModel: viewModel
            )
            
            navigationController?.pushViewController(viewController, animated: true)
            
        }
        
        delegate?.coordinator(self, didChangeStateFrom: oldState, to: newState)
        
    }
    
}
