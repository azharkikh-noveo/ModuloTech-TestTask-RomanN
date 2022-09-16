//
//  ShutterSettingsRoute.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 16.09.2022.
//

import UIKit


// MARK: - Protocol

/// Route that leads to the roller shutter device settings screen.
public protocol ShutterSettingsRoute {
    
    
    /// Navigates to the roller shutter device settings screen.
    func openShutterSettings(for device: RollerShutter)
    
}


// MARK: - Implementation

extension ShutterSettingsRoute where Self: Router {
    
    
    public func openShutterSettings(for device: RollerShutter) {
        
        let push = PushTransition()
        let router = BaseRouter(rootTransition: push)
        
        let viewModel = ShutterSettingsViewModel(router: router, device: device)
        let viewController = ShutterSettingsViewController(viewModel: viewModel)
        
        router.rootViewController = viewController
        
        route(to: viewController, as: push, completion: nil)
        
    }
    
}


// MARK: - Router extension

extension BaseRouter: ShutterSettingsRoute {
    
}
