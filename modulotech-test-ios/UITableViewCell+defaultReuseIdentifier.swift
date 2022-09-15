//
//  UITableViewCell+defaultReuseIdentifier.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit


extension UITableViewCell {
    
    
    /// Returns a cell class name.
    public static var defaultReuseIdentifier: String {
        return String(describing: Self.self)
    }
    
}

