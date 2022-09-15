//
//  BaseView.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit
import Combine


// MARK: - View

/// Base class for custom views.
public class BaseView: UIView {
    
    
    /// Storage for the subscriptions.
    public var disposeBag: Set<AnyCancellable> = []
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviewHierarchy()
        setupSubviewConstraints()
        setupSubviewBindings()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setups initial subview hierarchy. Should be called once.
    public func setupSubviewHierarchy() {
        
    }
    
    /// Setups initial subview constraints. Should be called once and after `setupSubviewHierarchy`.
    public func setupSubviewConstraints() {
        
    }
    
    /// Setups subview bindings. Should be called once.
    public func setupSubviewBindings() {
        
    }
    
    /// Setups initial subview properties. Should be called once and after all setup methods.
    public func setupSubviews() {
        
    }
    
}
