//
//  DeviceListViewModel.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation
import Combine


// MARK: - View-model

/// Viewmodel of the device list screen.
public final class DeviceListViewModel: BaseViewModel {
    
    
    /// Cancellable subscription for the device list.
    private var deviceListDownloadCancellable: AnyCancellable? {
        willSet {
            deviceListDownloadCancellable?.cancel()
        }
    }
    
    
    /// Coordinator delegate.
    private weak var coordinatorDelegate: DeviceListCoordinatorDelegate?
    
    /// Used for backend calls.
    private let networkService: NetworkService
    
    /// Publishes devices to display.
    public private(set) var devices: Array<Device>
    
    
    // MARK: Publishers
    
    /// Whether a screen views should be reloaded depending on their data.
    public let shouldReloadDeviceList: PassthroughSubject<Void, Never>
    
    /// Screen UI state.
    public let screenState: CurrentValueSubject<DeviceListViewModel.State, Never>
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of a view-model and assignes a router and a network service to it.
    public init(
        networkService: NetworkService,
        coordinatorDelegate: DeviceListCoordinatorDelegate?
    ) {
        self.shouldReloadDeviceList = .init()
        self.screenState = .init(.loading)
        self.devices = []
        self.networkService = networkService
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    
    // MARK: View controller lifecycle
    
    public override func onViewDidLoad() {
        super.onViewDidLoad()
        loadDeviceList()
    }
    
    public override func onViewWillAppear() {
        super.onViewWillAppear()
        shouldReloadDeviceList.send()
    }
    
}


// MARK: Device list

extension DeviceListViewModel {
    
    
    /// Downloads the device list from the server.
    public func loadDeviceList() {
        
        screenState.send(.loading)
        
        deviceListDownloadCancellable = networkService
            .deviceList()
            .sink { [unowned self] completion in
                
                switch completion {
                case .finished:
                    screenState.send(.deviceList)
                case .failure(let error):
                    devices = []
                    screenState.send(.error(error))
                }
                
                shouldReloadDeviceList.send()
                
            } receiveValue: { [unowned self] deviceList in
                
                devices = deviceList
                screenState.send(.deviceList)
                
            }
        
    }
    
}


// MARK: Navigation

extension DeviceListViewModel {
    
    
    /// Opens a device settings screen for a specific device.
    public func openSettingsScreen(for device: Device) {
        switch device {
        case let light as Light:
            coordinatorDelegate?.viewModel(self, didSelectDevice: light)
        case let heater as Heater:
            coordinatorDelegate?.viewModel(self, didSelectDevice: heater)
        case let shutter as RollerShutter:
            coordinatorDelegate?.viewModel(self, didSelectDevice: shutter)
        default:
            preconditionFailure("Unknown device kind found. Check the flow.")
        }
    }
    
}
