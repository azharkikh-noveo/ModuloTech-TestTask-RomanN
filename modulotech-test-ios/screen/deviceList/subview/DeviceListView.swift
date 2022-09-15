//
//  DeviceListView.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit


// MARK: - View

/// Content view of a device list screen.
public final class DeviceListView: BaseView {
    
    
    // MARK: Subviews
    
    /// Device list table view.
    @AutoLayout public var tableView: UITableView = UITableView(frame: .zero)
    
    
    // MARK: Lifecycle
    
    /// Setups initial subview hierarchy. Should be called once.
    public override func setupSubviewHierarchy() {
        super.setupSubviewHierarchy()
        addSubview(tableView)
    }
    
    /// Setups initial subview constraints. Should be called once and after `setupSubviewHierarchy`.
    public override func setupSubviewConstraints() {
        super.setupSubviewConstraints()
    }
    
    /// Setups subview bindings. Should be called once.
    public override func setupSubviewBindings() {
        super.setupSubviewBindings()
    }
    
    /// Setups initial subview properties. Should be called once and after all setup methods.
    public override func setupSubviews() {
        super.setupSubviews()
    }
    
}
