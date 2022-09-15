//
//  DeviceListViewModel.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import Foundation
import Combine


// MARK: - View-model

/// Viewmodel of the device list screen.
public final class DeviceListViewModel: BaseViewModel {
    
    
    /// Router type used by the view-model.
    public typealias RouterType = Router
    
    /// Assigned router.
    private let router: DeviceListViewModel.RouterType
    
    /// Used for backend calls.
    private let networkService: NetworkService
    
    
    // MARK: Publishers
    
    /// Publishes devices to display.
    public let devices: CurrentValueSubject<Array<Device>, Never> = .init([])
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of a view-model and assignes a router to it.
    public init(
        router: DeviceListViewModel.RouterType,
        networkService: NetworkService
    ) {
        self.router = router
        self.networkService = networkService
    }
    
    
    // MARK: View controller lifecycle
    
    public override func onViewDidLoad() {
        
        super.onViewDidLoad()
        
        networkService
            .deviceList()
            .sink { [unowned self] completion in
                
                switch completion {
                case .finished:
                    break
                case .failure:
                    devices.send([])
                }
                
            } receiveValue: { [unowned self] deviceList in
                
                devices.send(deviceList)
                
            }
            .store(in: &disposeBag)
        
    }
    
}


// MARK: Navigation

extension DeviceListViewModel {
    
    
    /// Opens a device settings screen for a specific device.
    public func openSettingsScreen(for device: Device) {
        
        print(device)
        
    }
    
}
