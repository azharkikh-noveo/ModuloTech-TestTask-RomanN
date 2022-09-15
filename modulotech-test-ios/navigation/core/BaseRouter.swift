//
//  BaseRouter.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit


// MARK: - Router

/// Base class for routers that manage the app navigation. Can be used for routing without subclassing.
public class BaseRouter: NSObject, Router {
    
    
    public weak var rootViewController: UIViewController?
    
    /// Root transition assigned to the router.
    private let rootTransition: Transition
    
    /// Creates an instance of a router and assignes a root transition to it.
    public init(rootTransition: Transition) {
        self.rootTransition = rootTransition
    }
    
    public func route(
        to viewController: UIViewController,
        as transition: Transition,
        completion: (() -> Void)? = nil
    ) {
        
        if let rootViewController = rootViewController {
            
            transition.open(
                viewController,
                from: rootViewController,
                completion: completion
            )
            
        }
        
    }
    
    public func close(completion: (() -> Void)? = nil) {
        
        if let rootViewController = rootViewController {
            rootTransition.close(rootViewController, completion: completion)
        }
        
    }
    
    
    public func dismiss(completion: (() -> Void)? = nil) {
        
        rootViewController?.dismiss(
            animated: rootTransition.isAnimated,
            completion: completion
        )
        
    }
    
}
