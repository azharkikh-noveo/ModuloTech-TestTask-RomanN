//
//  EmptyTransition.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit


/// Empty transition that neither opens, nor closes screens.
public final class EmptyTransition: Transition {
    
    public var isAnimated: Bool = false
    
    public func open(
        _ viewController: UIViewController,
        from sourceViewController: UIViewController,
        completion: (() -> Void)? = nil
    ) {
        
    }
    
    public func close(
        _ viewController: UIViewController,
        completion: (() -> Void)? = nil
    ) {
        
    }
    
}

