//
//  UITableView+dequeue.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit


extension UITableView {
    
    
    /// Returns a reusable table-view cell object for the specified class and adds it to the table.
    /// - Parameters:
    ///   - cell: Cell class.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A registred UITableViewCell object. This method always returns a valid cell.
    public func dequeue<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
    }
    
    /// Returns a reusable table-view cell object for the specified class and adds it to the table.
    /// - Parameters:
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A registred UITableViewCell object. This method always returns a valid cell.
    public func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeue(T.self, for: indexPath)
    }
    
}

