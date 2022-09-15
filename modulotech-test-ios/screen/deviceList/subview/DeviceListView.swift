//
//  DeviceListView.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit
import SnapKit


// MARK: - View

/// Content view of a device list screen.
public final class DeviceListView: BaseView {
    
    
    // MARK: Subviews
    
    /// Device list table view.
    @AutoLayout public var tableView: UITableView = UITableView(frame: .zero)
    
    
    // MARK: Lifecycle
    
    public override func setupSubviewHierarchy() {
        super.setupSubviewHierarchy()
        addSubview(tableView)
    }
    
    public override func setupSubviewConstraints() {
        
        super.setupSubviewConstraints()
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
    public override func setupSubviewBindings() {
        super.setupSubviewBindings()
    }
    
    public override func setupSubviews() {
        
        super.setupSubviews()
        
        tableView.register(cellClass: DeviceListTableViewCell.self)
        tableView.rowHeight = DeviceListTableViewCell.preferredHeight
        tableView.estimatedRowHeight = DeviceListTableViewCell.preferredHeight
        tableView.separatorStyle = .none
        
    }
    
}
