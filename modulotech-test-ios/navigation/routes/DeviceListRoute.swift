//
//  DeviceListRoute.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit


// MARK: - Protocol

/// Route that leads from the app entry point to the device list.
public protocol DeviceListRoute {
    
    
    /// Creates a device list screen and embeds it into the navigation controller.
    ///
    /// - Returns: The root navigation controller.
    func makeRootViewController() -> UIViewController
    
}


// MARK: - Implementation

extension DeviceListRoute where Self: Router {
    
    
    public func makeRootViewController() -> UIViewController {
        
        let empty = EmptyTransition()
        let router = BaseRouter(rootTransition: empty)
        
        let viewModel = DeviceListViewModel(router: router)
        let viewController = DeviceListViewController(viewModel: viewModel)
        
        router.rootViewController = viewController
        
        let navigationController = BaseNavigationController()
        navigationController.viewControllers = [viewController]
        navigationController.isNavigationBarHidden = true
        
        return navigationController
        
    }
    
}


// MARK: - Router extension

extension BaseRouter: DeviceListRoute {
    
}
