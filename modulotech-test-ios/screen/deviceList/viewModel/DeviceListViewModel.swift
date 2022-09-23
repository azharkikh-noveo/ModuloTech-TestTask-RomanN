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
    public private(set) var devices: Array<DeviceKind>
    
    
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
    public func openSettingsScreen(for deviceKind: DeviceKind) {
        
        do {
            
            switch deviceKind {
            case .light(let light):
                try coordinator?.changeState(to: .lightSettings(device: light))
            case .heater(let heater):
                try coordinator?.changeState(to: .heaterSettings(device: heater))
            case .rollerShutter(let shutter):
                try coordinator?.changeState(to: .rollerShutterSettings(device: shutter))
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
        
        var modifiedDevice: DeviceKind
        
        switch oldState {
        case .lightSettings(let device):
            modifiedDevice = .light(device)
        case .heaterSettings(let device):
            modifiedDevice = .heater(device)
        case .rollerShutterSettings(let device):
            modifiedDevice = .rollerShutter(device)
        case .deviceList:
            return
        }
        
        let deviceIDs: Array<Int> = devices.map { $0.device.deviceId }
        
        guard let i = deviceIDs.firstIndex(of: modifiedDevice.device.deviceId) else {
            return
        }
        
        devices[i] = modifiedDevice
        
        shouldReloadDeviceList.send()
        
    }
    
}
