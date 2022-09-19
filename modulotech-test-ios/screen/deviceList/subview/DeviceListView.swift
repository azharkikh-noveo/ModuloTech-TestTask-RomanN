//
//  DeviceListView.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit
import SnapKit


// MARK: - View

/// Content view of a device list screen.
public final class DeviceListView: BaseView {
    
    
    // MARK: Subviews
    
    /// Device list table view.
    @AutoLayout public var tableView: UITableView = UITableView(frame: .zero)
    
    /// Activity indicator for loading state.
    @AutoLayout public var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: .zero)
    
    /// Label that describes the current activity.
    @AutoLayout public var activityDescriptionLabel: UILabel = UILabel(frame: .zero)
    
    
    // MARK: Lifecycle
    
    public override func setupSubviewHierarchy() {
        super.setupSubviewHierarchy()
        addSubview(activityIndicator)
        addSubview(activityDescriptionLabel)
        addSubview(tableView)
    }
    
    public override func setupSubviewConstraints() {
        
        super.setupSubviewConstraints()
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        activityDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(activityIndicator.snp.bottom).offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
    public override func setupSubviews() {
        
        super.setupSubviews()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = Asset.Colors.darkGray.color
        
        activityDescriptionLabel.font = .primary(ofSize: 18, .semibold)
        activityDescriptionLabel.textColor = Asset.Colors.black.color
        activityDescriptionLabel.textAlignment = .center
        activityDescriptionLabel.numberOfLines = 0
        activityDescriptionLabel.minimumScaleFactor = 0.5
        
        tableView.register(cellClass: DeviceListTableViewCell.self)
        tableView.rowHeight = DeviceListTableViewCell.preferredHeight
        tableView.estimatedRowHeight = DeviceListTableViewCell.preferredHeight
        tableView.separatorStyle = .none
        tableView.backgroundColor = Asset.Colors.white.color
        
    }
    
    
    // MARK: Helper
    
    /// Shows a loading error message.
    public func showLoadingErrorState(for error: Error) {
        tableView.isHidden = true
        activityIndicator.stopAnimating()
        activityDescriptionLabel.text = L10n.DeviceList.State.loadingError(error.localizedDescription)
        activityDescriptionLabel.sizeToFit()
    }
    
    /// Shows an activity indicator state.
    public func showLoadingState() {
        tableView.isHidden = true
        activityIndicator.startAnimating()
        activityDescriptionLabel.text = L10n.DeviceList.State.loading
        activityDescriptionLabel.sizeToFit()
    }
    
    /// Shows a content view.
    public func showTableView() {
        tableView.isHidden = false
        activityIndicator.stopAnimating()
    }
    
}
