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
    
    
    /// Reference to a coordinator.
    private weak var coordinator: DeviceSettingsCoordinator?
    
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
        coordinator: DeviceSettingsCoordinator?
    ) {
        self.shouldReloadDeviceList = .init()
        self.screenState = .init(.loading)
        self.devices = []
        self.networkService = networkService
        self.coordinator = coordinator
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
        
        do {
            
            switch device {
            case let light as Light:
                try coordinator?.changeState(to: .lightSettings(device: light))
            case let heater as Heater:
                try coordinator?.changeState(to: .heaterSettings(device: heater))
            case let shutter as RollerShutter:
                try coordinator?.changeState(to: .rollerShutterSettings(device: shutter))
            default:
                preconditionFailure("Unknown device kind found. Check the flow.")
            }
            
        } catch let error {
            
            print(error.localizedDescription)
            
        }
        
    }
    
}


// MARK: DeviceSettingsCoordinatorDelegate

extension DeviceListViewModel: DeviceSettingsCoordinatorDelegate {
    
    
    public func coordinator(
        _ coordinator: DeviceSettingsCoordinator,
        willChangeStateFrom oldState: DeviceSettingsCoordinator.State,
        to newState: DeviceSettingsCoordinator.State
    ) {
        
        switch newState {
        case .deviceList:
            break
        default:
            return
        }
        
        var modifiedDevice: Device
        
        switch oldState {
        case .lightSettings(let device):
            modifiedDevice = device
        case .heaterSettings(let device):
            modifiedDevice = device
        case .rollerShutterSettings(let device):
            modifiedDevice = device
        case .deviceList:
            return
        }
        
        guard let i = devices.map(\.deviceId).firstIndex(of: modifiedDevice.deviceId) else {
            return
        }
        
        devices[i] = modifiedDevice
        
        shouldReloadDeviceList.send()
        
    }
    
}
