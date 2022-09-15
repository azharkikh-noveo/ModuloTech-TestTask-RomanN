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
    public typealias RouterType = Router & LightSettingsRoute
    
    /// Assigned router.
    private let router: DeviceListViewModel.RouterType
    
    /// Used for backend calls.
    private let networkService: NetworkService
    
    /// Publishes devices to display.
    public private(set) var devices: Array<Device>
    
    
    // MARK: Publishers
    
    /// Whether a screen views should be reloaded depending on their data.
    public let shouldUpdateScreen: PassthroughSubject<Void, Never>
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of a view-model and assignes a router and a network service to it.
    public init(
        router: DeviceListViewModel.RouterType,
        networkService: NetworkService
    ) {
        self.devices = []
        self.shouldUpdateScreen = .init()
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
                    devices = []
                }
                
                shouldUpdateScreen.send()
                
            } receiveValue: { [unowned self] deviceList in
                
                devices = deviceList
                
            }
            .store(in: &disposeBag)
        
    }
    
    public override func onViewWillAppear() {
        super.onViewWillAppear()
        shouldUpdateScreen.send()
    }
    
}


// MARK: Navigation

extension DeviceListViewModel {
    
    
    /// Opens a device settings screen for a specific device.
    public func openSettingsScreen(for device: Device) {
        
        switch device {
        case let light as Light:
            router.openLightSettings(for: light)
        case let heater as Heater:
            break
        case let shutter as RollerShutter:
            break
        default:
            fatalError("Unknown device kind found. Check the flow.")
        }
        
    }
    
}
