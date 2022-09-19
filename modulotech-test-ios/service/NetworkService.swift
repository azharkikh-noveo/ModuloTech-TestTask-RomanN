//
//  NetworkService.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation
import Combine


// MARK: - Service

/// Manages backed requests and network related tasks.
public final class NetworkService {
    
    
    /// Storage for the subscriptions.
    public var disposeBag: Set<AnyCancellable> = []
    
    
    /// Fetches the device list from the server.
    public func deviceList() -> AnyPublisher<Array<Device>, Error> {
        
        let url: URL = URL(string: "http://storage42.com/modulotest/data.json")!
        
        let publisher: AnyPublisher<Array<Device>, Error> = URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: DeviceListResponse.self, decoder: JSONDecoder())
            .map(\.devices)
            .map { rawModels in
                
                return rawModels.compactMap { product in
                    switch product.productType {
                    case .heater:
                        return Heater(from: product)
                    case .light:
                        return Light(from: product)
                    case .rollerShutter:
                        return RollerShutter(from: product)
                    }
                }
                
            }
            .eraseToAnyPublisher()
        
        publisher.sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("Network request failed due to \(error.localizedDescription)")
            }
        } receiveValue: { devices in
            
            print("Received a device list:")
            print(devices.map { " - " + $0.description }.joined(separator: "\n"))
            print("\n")
            
        }
        .store(in: &disposeBag)
        
        return publisher
        
    }
    
}
