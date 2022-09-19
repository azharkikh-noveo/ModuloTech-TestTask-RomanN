//
//  ApplicationCoordinator.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


// MARK: - Coordinator

/// Main coordinator of the application that is owned by the AppDelegate.
public final class ApplicationCoordinator: Coordinator {
    
    
    /// Managed window.
    public let window: UIWindow
    
    /// Root view controller
    public private(set) var deviceListCoordinator: DeviceListCoordinator?
    
    /// Netowork service used for backend calls.
    public private(set) var networkService: NetworkService
    
    
    // MARK: Init
    
    /// Creates an instance of a coordinator for a specific window.
    public init(window: UIWindow) {
        self.networkService = NetworkService()
        self.deviceListCoordinator = nil
        self.window = window
    }
    
    public func viewController() -> UIViewController {
        
        let coordinator = DeviceListCoordinator(networkService: networkService)
        let viewController: UIViewController = coordinator.viewController()
        
        deviceListCoordinator = coordinator
        
        return viewController
        
    }
    
    
    // MARK: Open
    
    public func openDeviceList() {
        window.backgroundColor = Asset.Colors.white.color
        window.rootViewController = viewController()
        window.makeKeyAndVisible()
    }
    
}
