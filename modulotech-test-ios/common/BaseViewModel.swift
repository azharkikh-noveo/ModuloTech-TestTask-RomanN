//
//  BaseViewModel.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation
import Combine


/// Base class for the view controller view-models.
public class BaseViewModel {
    
    
    /// Storage for the subscriptions.
    public var disposeBag: Set<AnyCancellable> = []
    
    /// Creates an instance of a view-model.
    public init() {
        
    }
    
}
