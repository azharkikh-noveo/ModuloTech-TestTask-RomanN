//
//  LightSettingsRoute.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit


// MARK: - Protocol

/// Route that leads to the light device settings screen.
public protocol LightSettingsRoute {
    
    
    /// Navigates to the light device settings screen.
    func openLightSettings(for device: Light)
    
}


// MARK: - Implementation

extension LightSettingsRoute where Self: Router {
    
    
    public func openLightSettings(for device: Light) {
        
        let push = PushTransition()
        let router = BaseRouter(rootTransition: push)
        
        let viewModel = LightSettingsViewModel(router: router, device: device)
        let viewController = LightSettingsViewController(viewModel: viewModel)
        
        router.rootViewController = viewController
       
        route(to: viewController, as: push, completion: nil)
        
    }
    
}


// MARK: - Router extension

extension BaseRouter: LightSettingsRoute {
    
}
