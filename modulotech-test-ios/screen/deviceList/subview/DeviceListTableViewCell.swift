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
    
    /// Device description label.
    @AutoLayout public var deviceDescriptionLabel: UILabel = UILabel(frame: .zero)
    
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
        
        containerStackView.addArrangedSubview(stateImageView)
        containerStackView.addArrangedSubview(labelsStackView)
        
        labelsStackView.addArrangedSubview(deviceTitleLabel)
        labelsStackView.addArrangedSubview(deviceDescriptionLabel)
        
    }
    
    
    public override func setupSubviewConstraints() {
        
        super.setupSubviewConstraints()
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.left.right.equalToSuperview().inset(22)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.left.right.equalToSuperview().inset(14)
        }
        
        stateImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.height.equalTo(28)
        }
        
        labelsStackView.snp.makeConstraints { make in
            make.right.equalToSuperview()
        }
        
    }
    
    public override func setupSubviews() {
        
        super.setupSubviews()
        
        contentView.backgroundColor = Asset.Colors.white.color
        
        containerStackView.axis = .horizontal
        containerStackView.spacing = 30
        containerStackView.alignment = .center
        
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 6
        labelsStackView.alignment = .leading
        
        deviceTitleLabel.font = .primary(ofSize: 18, .bold)
        deviceTitleLabel.textColor = Asset.Colors.darkGray.color
        
        deviceDescriptionLabel.font = .primary(ofSize: 16, .semibold)
        deviceDescriptionLabel.textColor = Asset.Colors.gray.color
        
        containerView.backgroundColor = Asset.Colors.white.color
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
            
            switch light.mode {
            case .on:
                stateImageView.image = Asset.Images.Device.deviceLightOnIcon.image
                deviceDescriptionLabel.text = "Light: on at \(light.intensity)"
            case .off:
                stateImageView.image = Asset.Images.Device.deviceLightOffIcon.image
                deviceDescriptionLabel.text = "Light: off"
            }
            
        case let heater as Heater:
            
            switch heater.mode {
            case .on:
                stateImageView.image = Asset.Images.Device.deviceHeaterOnIcon.image
                deviceDescriptionLabel.text = "Heater: on at " + String(format: "%.1f", heater.temperature) + "°C"
            case .off:
                stateImageView.image = Asset.Images.Device.deviceHeaterOffIcon.image
                deviceDescriptionLabel.text = "Heater: off"
            }
            
        case let shutter as RollerShutter:
            
            stateImageView.image = Asset.Images.Device.deviceRollerShutterIcon.image
            
            if shutter.position == 0 {
                
                deviceDescriptionLabel.text = "Roller shutter: closed"
                
            } else if shutter.position == 100 {
                
                deviceDescriptionLabel.text = "Roller shutter: opened"
                
            } else {
             
                deviceDescriptionLabel.text = "Roller shutter: opened at \(shutter.position)%"
                
            }
            
        default:
            fatalError("Unknown device found.")
        }
        
    }
    
}
