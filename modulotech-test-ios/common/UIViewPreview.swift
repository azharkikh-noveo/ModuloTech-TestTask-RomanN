//
//  UIViewPreview.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit
import SwiftUI


/// SwiftUI preview for UIKit views.
public struct UIViewPreview<UIViewBody: UIView>: UIViewRepresentable {
    
    
    private let view: UIViewBody
    
    /// Creates an instance using closure builder for the view.
    public init(_ builder: @escaping () -> UIViewBody) {
        view = builder()
    }
    
    public func makeUIView(context: Context) -> UIView {
        return view
    }
    
    public func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
}
