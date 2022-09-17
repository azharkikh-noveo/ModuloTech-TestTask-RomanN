//
//  NavigationBarView.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit
import SnapKit


// MARK: - View

/// Custom navigation bar view.
public final class NavigationBarView: BaseView {
    
    
    /// Preferred view height.
    public static let preferredHeight: CGFloat = 60
    
    
    // MARK: Subviews
    
    /// Label at the center of a view.
    @AutoLayout public var titleLabel: UILabel = UILabel(frame: .zero)
    
    /// Back button.
    @AutoLayout public var backButton: UIButton = UIButton(frame: .zero)
    
    
    // MARK: Lifecycle
    
    public override func setupSubviewHierarchy() {
        super.setupSubviewHierarchy()
        addSubview(titleLabel)
        addSubview(backButton)
    }
    
    public override func setupSubviewConstraints() {
        
        super.setupSubviewConstraints()
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(30)
            make.width.height.equalTo(34)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(80)
        }
        
    }
    
    public override func setupSubviews() {
        
        super.setupSubviews()
        
        titleLabel.font = .primary(ofSize: 18, .semibold)
        titleLabel.textColor = Asset.Colors.darkGray.color
        titleLabel.textAlignment = .center
        titleLabel.minimumScaleFactor = 0.5
        
        backButton.setImage(.init(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = Asset.Colors.darkGray.color
        backButton.backgroundColor = Asset.Colors.white.color
        backButton.layer.cornerRadius = 15
        backButton.layer.shadowRadius = 3
        backButton.layer.shadowOffset = .zero
        backButton.layer.shadowOpacity = 0.5
        backButton.layer.shadowColor = Asset.Colors.gray.color.cgColor
        
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        backButton.layer.shadowPath = UIBezierPath(
            ovalIn: backButton.bounds
        )
        .cgPath
        
    }
    
}
