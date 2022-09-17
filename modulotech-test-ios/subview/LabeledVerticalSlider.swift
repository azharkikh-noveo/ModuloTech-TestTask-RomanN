//
//  LabeledVerticalSlider.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 17.09.2022.
//

import UIKit
import SnapKit


// MARK: - View

/// Horizontal slider with description label.
public final class LabeledVerticalSlider: BaseView {
    
    
    /// Preferred view height.
    public static let preferredHeight: CGFloat = 200
    
    
    // MARK: Subviews
    
    /// Title label.
    @AutoLayout public var titleLabel: UILabel = UILabel(frame: .zero)
    
    /// Slider.
    @AutoLayout public var slider: VerticalSlider = VerticalSlider(frame: .zero)
    
    
    // MARK: Lifecycle
    
    public override func setupSubviewHierarchy() {
        
        super.setupSubviewHierarchy()
        
        addSubview(titleLabel)
        addSubview(slider)
        
    }
    
    public override func setupSubviewConstraints() {
        
        super.setupSubviewConstraints()
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        slider.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(snp.width)
            make.bottom.equalToSuperview()
        }
        
    }
    
    public override func setupSubviews() {
        
        super.setupSubviews()
        
        titleLabel.font = .primary(ofSize: 18, .bold)
        titleLabel.textColor = Asset.Colors.darkGray.color
        titleLabel.textAlignment = .center
        
    }
    
}
