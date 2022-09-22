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
    
    /// Base domain for all requests that can be performed by this server.
    private let domain: String
    
    
    /// Creates an instance of a service for a specified domain.
    public init(domain: String) {
        self.domain = domain
    }
    
    
    /// Fetches the device list from the server.
    ///
    /// Publishes `NetworkServiceError` if an error occured somewhere in the service except for the network part.
    public func deviceList() -> AnyPublisher<Array<DeviceKind>, Error> {
        
        guard let url = URL(string: domain)?.appendingPathComponent("modulotest/data.json") else {
            return Fail(error: NetworkServiceError.cannotComposeURL)
                .eraseToAnyPublisher()
        }
        
        let publisher: AnyPublisher<Array<DeviceKind>, Error> = URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: DeviceListResponse.self, decoder: JSONDecoder())
            .map(\.devices)
            .map { $0.compactMap(DeviceKind.init(rawModel:)) }
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
            print(devices.map { " - " + $0.device.description }.joined(separator: "\n"))
            print("\n")
            
        }
        .store(in: &disposeBag)
        
        return publisher
        
    }
    
}


// MARK: Error

extension NetworkService {
    
    
    /// Errors that can occur in the network service.
    public enum NetworkServiceError: Error {
        
        /// URL for request cannot be composed from the domain and the path.
        case cannotComposeURL
        
    }
    
}
