//
//  Coordinator.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


/// A coordinator protocol.
public protocol Coordinator {
    
    
    /// Starts a coordinator flow and returns its root view controller.
    func viewController() -> UIViewController
    
}
