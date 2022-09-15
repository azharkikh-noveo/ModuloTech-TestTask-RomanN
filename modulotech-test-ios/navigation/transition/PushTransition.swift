//
//  PushTransition.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit


// MARK: - Transition

/// Transition used for push/pop presentations.
///
/// - Warning: Sets `delegate` property of the transition source view controller.
public final class PushTransition: NSObject, Transition {
    
    
    /// View controller to start the transition.
    private weak var navigationSourceViewController: UIViewController?
    
    /// Completion to be called after push animation.
    private var openCompletionHandler: (() -> Void)?
    
    /// Completion to be called after pop animation.
    private var closeCompletionHandler: (() -> Void)?
    
    /// Navigation controller to perform the transition.
    private var navigationController: UINavigationController? {
        
        if let asNavigationController = navigationSourceViewController as? UINavigationController {
            return asNavigationController
        }
        
        return navigationSourceViewController?.navigationController
        
    }
    
    
    /// Creates an instance of a transition.
    public override init() {
        super.init()
    }
    
    
    // MARK: Transition protocol
    
    public var isAnimated: Bool = true
    
    public func open(
        _ viewController: UIViewController,
        from sourceViewController: UIViewController,
        completion: (() -> Void)? = nil
    ) {
        openCompletionHandler = completion
        navigationSourceViewController = sourceViewController
        navigationController?.delegate = self
        navigationController?.pushViewController(viewController, animated: isAnimated)
    }
    
    public func close(
        _ viewController: UIViewController,
        completion: (() -> Void)? = nil
    ) {
        closeCompletionHandler = completion
        navigationController?.popViewController(animated: isAnimated)
    }
    
}


// MARK: - UINavigationControllerDelegate

extension PushTransition: UINavigationControllerDelegate {
    
    
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        
        guard
            let coordinator = navigationController.transitionCoordinator,
            let fromVC = coordinator.viewController(forKey: .from),
            let toVC = coordinator.viewController(forKey: .to)
        else {
            return
        }
        
        if navigationSourceViewController === fromVC {
            
            openCompletionHandler?()
            openCompletionHandler = nil
            
        } else if navigationSourceViewController === toVC {
            
            closeCompletionHandler?()
            closeCompletionHandler = nil
            
        }
        
    }
    
}
