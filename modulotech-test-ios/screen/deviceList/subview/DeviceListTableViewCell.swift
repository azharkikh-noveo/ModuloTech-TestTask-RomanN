//
//  DeviceListTableViewCell.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
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
    private let containerStackView: UIStackView = UIStackView(frame: .zero)
    
    /// Cell labels stack view.
    private let labelsStackView: UIStackView = UIStackView(frame: .zero)
    
    /// Cell content container view.
    public let containerView: UIView = UIView(frame: .zero)
    
    /// Device title label.
    public let deviceTitleLabel: UILabel = UILabel(frame: .zero)
    
    /// Device description label.
    public let deviceDescriptionLabel: UILabel = UILabel(frame: .zero)
    
    /// Device state image view.
    public let stateImageView: UIImageView = UIImageView(frame: .zero)
    
    
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
    public func assign(_ deviceKind: DeviceKind) {
        
        deviceTitleLabel.text = deviceKind.device.name
        
        switch deviceKind {
        case .light(let light):
            
            switch light.mode {
            case .on:
                stateImageView.image = Asset.Images.Device.deviceLightOnIcon.image
                deviceDescriptionLabel.text = L10n.Device.Light.DeviceListState.onAt(
                    light.intensity
                )
            case .off:
                stateImageView.image = Asset.Images.Device.deviceLightOffIcon.image
                deviceDescriptionLabel.text = L10n.Device.Light.DeviceListState.off
            }
            
        case .heater(let heater):
            
            switch heater.mode {
            case .on:
                let temperature = String(format: "%.1f", heater.temperature)
                stateImageView.image = Asset.Images.Device.deviceHeaterOnIcon.image
                deviceDescriptionLabel.text = L10n.Device.Heater.DeviceListState.onAt(temperature)
            case .off:
                stateImageView.image = Asset.Images.Device.deviceHeaterOffIcon.image
                deviceDescriptionLabel.text = L10n.Device.Heater.DeviceListState.off
            }
            
        case .rollerShutter(let shutter):
            
            stateImageView.image = Asset.Images.Device.deviceRollerShutterIcon.image
            
            if shutter.position == 0 {
                
                deviceDescriptionLabel.text = L10n.Device.RollerShutter.DeviceListState.closed
                
            } else if shutter.position == 100 {
                
                deviceDescriptionLabel.text = L10n.Device.RollerShutter.DeviceListState.opened
                
            } else {
             
                deviceDescriptionLabel.text = L10n.Device.RollerShutter.DeviceListState.openedAt(
                    shutter.position
                )
                
            }
            
        }
        
    }
    
}
