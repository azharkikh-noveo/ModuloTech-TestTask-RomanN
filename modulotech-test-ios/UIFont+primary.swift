//
//  UIFont+primary.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit


extension UIFont {
    
    
    /// Returns the font object for the primary family of the application in the specified size and weight.
    ///
    /// - Warning: The provided family might miss some system font weights. Check the bundle and the *Info.plist* for the available ones.
    public static func primary(ofSize size: CGFloat, _ weight: UIFont.Weight) -> UIFont {
        return .systemFont(ofSize: size, weight: weight)
    }
    
}
