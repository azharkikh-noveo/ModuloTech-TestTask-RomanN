//
//  UITableView+register.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


extension UITableView {
    
    
    /// Registers a class for use in creating new table cells.
    public func register<T: UITableViewCell>(cellClass cell: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
}
