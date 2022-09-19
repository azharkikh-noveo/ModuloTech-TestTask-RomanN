//
//  BaseViewController.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit
import Combine


// MARK: - Controller

/// Base class for custom view controllers.
public class BaseViewController: UIViewController {
    
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    
    // MARK: Properties
    
    /// Storage for the subscriptions.
    ///
    /// - Warning: Should not be erased. Use custom bag for the erasable subscriptinos.
    public var disposeBag: Set<AnyCancellable> = []
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of view controller programmatically.
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Asset.Colors.white.color
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
}


// MARK: UIGestureRecognizerDelegate

extension BaseViewController: UIGestureRecognizerDelegate {
    
    
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
    
}
