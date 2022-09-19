//
//  DeviceInfoView.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit
import SnapKit


// MARK: - View

/// View with a device info.
public final class DeviceInfoView: BaseView {
    
    
    /// Preferred view height.
    public static let preferredHeight: CGFloat = 60
    
    
    // MARK: Subviews
    
    /// Vertical stack for the content.
    @AutoLayout private var stackView: UIStackView = UIStackView(frame: .zero)
    
    /// Device title/name label.
    @AutoLayout public var deviceTitleLabel: UILabel = UILabel(frame: .zero)
    
    /// Device type label.
    @AutoLayout public var deviceTypeLabel: UILabel = UILabel(frame: .zero)
    
    
    // MARK: Lifecycle
    
    public override func setupSubviewHierarchy() {
        
        super.setupSubviewHierarchy()
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(deviceTitleLabel)
        stackView.addArrangedSubview(deviceTypeLabel)
        
    }
    
    public override func setupSubviewConstraints() {
        
        super.setupSubviewConstraints()
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        deviceTitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        
        deviceTypeLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        
    }
    
    public override func setupSubviews() {
        
        super.setupSubviews()
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        
        deviceTitleLabel.font = .primary(ofSize: 18, .regular)
        deviceTitleLabel.textColor = Asset.Colors.darkGray.color
        deviceTitleLabel.textAlignment = .center
        
        deviceTypeLabel.font = .primary(ofSize: 16, .regular)
        deviceTypeLabel.textColor = Asset.Colors.gray.color
        deviceTypeLabel.textAlignment = .center
        
    }
    
}
