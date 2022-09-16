//
//  UITableView+register.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit


extension UITableView {
    
    
    /// Registers a class for use in creating new table cells.
    /// - Parameter cell: Cell class.
    public func register<T: UITableViewCell>(cellClass cell: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
}
