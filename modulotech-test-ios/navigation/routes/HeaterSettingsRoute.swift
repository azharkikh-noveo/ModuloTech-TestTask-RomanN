//
//  HeaterSettingsRoute.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 16.09.2022.
//

import UIKit


// MARK: - Protocol

/// Route that leads to the heater device settings screen.
public protocol HeaterSettingsRoute {
    
    
    /// Navigates to the heater device settings screen.
    func openHeaterSettings(for device: Heater)
    
}


// MARK: - Implementation

extension HeaterSettingsRoute where Self: Router {
    
    
    public func openHeaterSettings(for device: Heater) {
        
        let push = PushTransition()
        let router = BaseRouter(rootTransition: push)
        
        let viewModel = HeaterSettingsViewModel(router: router, device: device)
        let viewController = HeaterSettingsViewController(viewModel: viewModel)
        
        router.rootViewController = viewController
        
        route(to: viewController, as: push, completion: nil)
        
    }
    
}


// MARK: - Router extension

extension BaseRouter: HeaterSettingsRoute {
    
}

