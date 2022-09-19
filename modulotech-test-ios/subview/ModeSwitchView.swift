//
//  ModeSwitchView.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit
import SnapKit


// MARK: - View

/// View with device binary mode switching.
public final class ModeSwitchView: BaseView {
    
    
    /// Preferred view height.
    public static let preferredHeight: CGFloat = 60
    
    
    // MARK: Subviews
    
    /// Mode switch view.
    @AutoLayout public var switchView: UISwitch = UISwitch(frame: .zero)
    
    /// Mode title label.
    @AutoLayout public var titleLabel: UILabel = UILabel(frame: .zero)
    
    
    // MARK: Lifecycle
    
    public override func setupSubviewHierarchy() {
        
        super.setupSubviewHierarchy()
        
        addSubview(titleLabel)
        addSubview(switchView)
        
    }
    
    public override func setupSubviewConstraints() {
        
        super.setupSubviewConstraints()
        
        switchView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.right.equalTo(switchView).inset(40)
        }
        
    }
    
    public override func setupSubviews() {
        
        super.setupSubviews()
        
        switchView.tintColor = Asset.Colors.gray.color
        switchView.onTintColor = Asset.Colors.lightSteelBlue.color
        
        titleLabel.font = .primary(ofSize: 18, .bold)
        titleLabel.textColor = Asset.Colors.darkGray.color
        
    }
    
}
