//
//  DeviceListViewModel.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import Foundation


// MARK: - View-model

/// Viewmodel of the device list screen.
public final class DeviceListViewModel: BaseViewModel {
    
    
    /// Router type used by the view-model.
    public typealias RouterType = Router
    
    /// Assigned router.
    private let router: DeviceListViewModel.RouterType
    
    /// Creates an instance of a view-model and assignes a router to it.
    public init(router: DeviceListViewModel.RouterType) {
        self.router = router
    }
    
}


// MARK: Navigation

extension DeviceListViewModel {
    
}
