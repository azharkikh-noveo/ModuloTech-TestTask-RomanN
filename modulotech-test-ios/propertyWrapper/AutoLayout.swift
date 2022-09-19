//
//  AutoLayout.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


/// Property wrapper that automatically sets `translatesAutoresizingMaskIntoConstraints` to false for a view.
@propertyWrapper public struct AutoLayout<WrappedView: UIView> {
    
    public var wrappedValue: WrappedView {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    public init(wrappedValue value: WrappedView) {
        self.wrappedValue = value
        self.wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
