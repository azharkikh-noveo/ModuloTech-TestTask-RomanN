//
//  Router.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit
import Combine


/// A router that allows to navigate with its root view controller using transitions.
public protocol Router: AnyObject {
    
    
    /// Root screen of a router.
    var rootViewController: UIViewController? { get set }
    
    
    /// Routes to a screen using the provided transition.
    func route(
        to viewController: UIViewController,
        as transition: Transition,
        completion: (() -> Void)?
    )
    
    /// Closes the router's root screen *using* a transition used to show it.
    func close(completion: (() -> Void)?)
    
    /// Closes the router's root screen *ignoring* a transition used to show it.
    func dismiss(completion: (() -> Void)?)
    
}
