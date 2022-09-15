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
    
    /// Used for backend calls.
    private let networkService: NetworkService
    
    /// Creates an instance of a view-model and assignes a router to it.
    public init(
        router: DeviceListViewModel.RouterType,
        networkService: NetworkService
    ) {
        self.router = router
        self.networkService = networkService
    }
    
}


// MARK: Navigation

extension DeviceListViewModel {
    
}
