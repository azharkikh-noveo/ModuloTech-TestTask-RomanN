//
//  UITableView+dequeue.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


extension UITableView {
    
    
    /// Returns a reusable table-view cell object for the specified class and adds it to the table.
    public func dequeue<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
    }
    
    /// Returns a reusable table-view cell object for the specified class and adds it to the table.
    public func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeue(T.self, for: indexPath)
    }
    
}
