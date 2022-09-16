//
//  BaseNavigationController.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit
import Combine


// MARK: - Controller

/// Base class for custom navigation controllers.
public class BaseNavigationController: UINavigationController {
    
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }
    
    
    // MARK: Properties
    
    /// Storage for the subscriptions.
    public var disposeBag: Set<AnyCancellable> = []
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of a navigation controller programmatically and assignes a list of view controllers to it.
    public required init(viewControllers: Array<UIViewController> = []) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
