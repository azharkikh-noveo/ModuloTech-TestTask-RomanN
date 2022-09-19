//
//  DeviceListCoordinator.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


// MARK: - Delegate

/// The delegate of a device list screen. Should be used in view-model.
public protocol DeviceListCoordinatorDelegate: AnyObject {
    
    
    /// Asks a delegate to open the device settings screen.
    func viewModel(_ viewModel: DeviceListViewModel, didSelectDevice light: Light)

    /// Asks a delegate to open the device settings screen.
    func viewModel(_ viewModel: DeviceListViewModel, didSelectDevice heater: Heater)
    
    /// Asks a delegate to open the device settings screen.
    func viewModel(_ viewModel: DeviceListViewModel, didSelectDevice shutter: RollerShutter)
    
}


// MARK: - Coordinator

/// Coordinator of the device list screen.
public final class DeviceListCoordinator: Coordinator {
    
    
    /// Root view controller of the coordinator.
    public weak var rootViewController: UINavigationController?
    
    /// Coordinator for the heater settings.
    public private(set) var heaterSettingsCoordinator: HeaterSettingsCoordinator?
    
    /// Coordinator for the light settings.
    public private(set) var lightSettingsCoordinator: LightSettingsCoordinator?
    
    /// Coordinator for the shutter settings.
    public private(set) var rollerShutterSettingsCoordinator: RollerShutterSettingsCoordinator?
    
    /// Netowork service used for backend calls.
    public private(set) var networkService: NetworkService
    
    
    // MARK: Init
    
    /// Creates an instance of a coordinator with the netowrk service injected.
    public init(networkService: NetworkService) {
        self.networkService = networkService
        self.lightSettingsCoordinator = nil
        self.heaterSettingsCoordinator = nil
        self.rollerShutterSettingsCoordinator = nil
    }
    
    
    // MARK: Start
    
    public func viewController() -> UIViewController {
        
        let viewModel = DeviceListViewModel(
            networkService: networkService,
            coordinatorDelegate: self
        )
        let viewController = DeviceListViewController(viewModel: viewModel)
        
        let navigationController = BaseNavigationController()
        navigationController.viewControllers = [viewController]
        navigationController.isNavigationBarHidden = true
        
        rootViewController = navigationController
        
        return navigationController
        
    }
    
    
    // MARK: Open
    
    public func openLightSettings(for device: Light) {
        
        let coordinator = LightSettingsCoordinator(
            for: device,
            navigationController: rootViewController
        )
        let viewController: UIViewController = coordinator.viewController()
        
        lightSettingsCoordinator = coordinator
        
        rootViewController?.pushViewController(viewController, animated: true)
        
    }
    
    public func openHeaterSettings(for device: Heater) {
        
        let coordinator = HeaterSettingsCoordinator(
            for: device,
            navigationController: rootViewController
        )
        let viewController: UIViewController = coordinator.viewController()
        
        heaterSettingsCoordinator = coordinator
        
        rootViewController?.pushViewController(viewController, animated: true)
        
    }
    
    public func openRollerShutterSettings(for device: RollerShutter) {
        
        let coordinator = RollerShutterSettingsCoordinator(
            for: device,
            navigationController: rootViewController
        )
        let viewController: UIViewController = coordinator.viewController()
        
        rollerShutterSettingsCoordinator = coordinator
        
        rootViewController?.pushViewController(viewController, animated: true)
        
    }
    
}


// MARK: DeviceListCoordinatorDelegate

extension DeviceListCoordinator: DeviceListCoordinatorDelegate {
    
    
    public func viewModel(_ viewModel: DeviceListViewModel, didSelectDevice light: Light) {
        openLightSettings(for: light)
    }
    
    public func viewModel(_ viewModel: DeviceListViewModel, didSelectDevice heater: Heater) {
        openHeaterSettings(for: heater)
    }
    
    public func viewModel(
        _ viewModel: DeviceListViewModel,
        didSelectDevice shutter: RollerShutter
    ) {
        openRollerShutterSettings(for: shutter)
    }
    
}
