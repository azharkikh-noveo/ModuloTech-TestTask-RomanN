//
//  DeviceListTableViewCell.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit
import SnapKit


// MARK: - Cell

/// Device list table view cell.
public final class DeviceListTableViewCell: BaseTableViewCell {
    
    
    /// Preferred height of the cell in the table view.
    public static let preferredHeight: CGFloat = 100
    
    
    // MARK: Subviews
    
    /// Cell content horizontal stack view.
    @AutoLayout private var containerStackView: UIStackView = UIStackView(frame: .zero)
    
    /// Cell labels stack view.
    @AutoLayout private var labelsStackView: UIStackView = UIStackView(frame: .zero)
    
    /// Cell content container view.
    @AutoLayout public var containerView: UIView = UIView(frame: .zero)
    
    /// Device title label.
    @AutoLayout public var deviceTitleLabel: UILabel = UILabel(frame: .zero)
    
    /// Device type label.
    @AutoLayout public var deviceTypeLabel: UILabel = UILabel(frame: .zero)
    
    /// Device state image view.
    @AutoLayout public var stateImageView: UIImageView = UIImageView(frame: .zero)
    
    
    // MARK: Lifecycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setupSubviewHierarchy() {
        
        super.setupSubviewHierarchy()
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(labelsStackView)
        containerStackView.addArrangedSubview(stateImageView)
        
        labelsStackView.addArrangedSubview(deviceTitleLabel)
        labelsStackView.addArrangedSubview(deviceTypeLabel)
        
    }
    
    
    public override func setupSubviewConstraints() {
        
        super.setupSubviewConstraints()
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.left.right.equalToSuperview().inset(22)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(14)
        }
        
        labelsStackView.snp.makeConstraints { make in
            make.left.equalToSuperview()
        }
        
        stateImageView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
    }
    
    public override func setupSubviews() {
        
        super.setupSubviews()
        
        containerStackView.axis = .horizontal
        containerStackView.spacing = 30
        containerStackView.alignment = .center
        
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 12
        labelsStackView.alignment = .leading
        
        deviceTitleLabel.font = .primary(ofSize: 18, .bold)
        
        deviceTypeLabel.font = .primary(ofSize: 16, .semibold)
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.3
        
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        containerView.layer.shadowPath = UIBezierPath(
            roundedRect: containerView.bounds,
            cornerRadius: 12
        )
        .cgPath
        
    }
    
    
    // MARK: Assign
    
    /// Assignes a device to display.
    public func assign(_ device: Device) {
        
        deviceTitleLabel.text = device.name
        
        switch device {
        case let light as Light:
            
            deviceTypeLabel.text = "Light"
            
        case let heater as Heater:
            
            deviceTypeLabel.text = "Heater"
            
        case let shutter as RollerShutter:
            
            deviceTypeLabel.text = "Roller shutter"
            
        default:
            fatalError("Unknown device found.")
        }
        
    }
    
}
