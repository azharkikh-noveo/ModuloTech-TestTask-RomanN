//
//  BaseView.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit
import Combine


/// Base class for custom views.
public class BaseView: UIView {
    
    
    /// Storage for the subscriptions.
    public var disposeBag: Set<AnyCancellable> = []
    
}

