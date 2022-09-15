//
//  NetworkService.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import Foundation
import Combine


// MARK: - Service

/// Manages backed requests and network related tasks.
public final class NetworkService {
    
    
    /// Fetches the device list from the server.
    public func deviceList() -> AnyPublisher<Int, Error> {
        
        let url: URL = URL(string: "http://storage42.com/modulotest/data.json")!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Int.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
    
}
