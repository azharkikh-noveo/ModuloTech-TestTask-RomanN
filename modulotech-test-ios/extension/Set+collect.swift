//
//  Set+collect.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation
import Combine


public typealias DisposeBag = Set<AnyCancellable>


extension DisposeBag {
    
    
    @resultBuilder public struct Builder {
        
        static func buildBlock(_ cancellables: AnyCancellable...) -> Array<AnyCancellable> {
            return cancellables
        }
        
    }
    
    public mutating func collect(
        @Builder _ cancellables: () -> Array<AnyCancellable>
    ) {
        formUnion(cancellables())
    }
    
}
