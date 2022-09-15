//
//  Transition.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit


/// An API to screen opening/closing using provided animations.
public protocol Transition: AnyObject {
    
    
    /// Whether a transition should be animated.
    var isAnimated: Bool { get set }
    
    /// Opens a view controller from another one using this transition.
    func open(
        _ viewController: UIViewController,
        from sourceViewController: UIViewController,
        completion: (() -> Void)?
    )
    
    /// Closes a view controller using this transition.
    func close(
        _ viewController: UIViewController,
        completion: (() -> Void)?
    )
    
}
