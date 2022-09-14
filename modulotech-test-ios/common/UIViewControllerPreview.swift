//
//  UIViewControllerPreview.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit
import SwiftUI


/// SwiftUI preview for UIKit view controllers.
public struct UIViewControllerPreview<UIViewControllerBody: UIViewController>: UIViewControllerRepresentable {
    
    
    private let viewController: UIViewControllerBody
    
    /// Creates an instance using closure builder for the view controller.
    public init(_ builder: @escaping () -> UIViewControllerBody) {
        viewController = builder()
    }
    
    public func makeUIViewController(context: Context) -> UIViewControllerBody {
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerBody, context: Context) {
        
    }
    
}
