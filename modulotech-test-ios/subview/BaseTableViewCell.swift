//
//  BaseTableViewCell.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit
import Combine


// MARK: - View

/// Base class for table view custom cells.
public class BaseTableViewCell: UITableViewCell {
    
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviewHierarchy()
        setupSubviewConstraints()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Setups initial subview hierarchy. Should be called once.
    public func setupSubviewHierarchy() {
        
    }
    
    /// Setups initial subview constraints. Should be called once and after `setupSubviewHierarchy`.
    public func setupSubviewConstraints() {
        
    }
    
    /// Setups initial subview properties. Should be called once and after all setup methods.
    public func setupSubviews() {
        
    }
    
}
