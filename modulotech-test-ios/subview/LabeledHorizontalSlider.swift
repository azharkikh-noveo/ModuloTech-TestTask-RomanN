//
//  LabeledHorizontalSlider.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit
import SnapKit


// MARK: - View

/// Horizontal slider with description label.
public final class LabeledHorizontalSlider: BaseView {
    
    
    /// Preferred view height.
    public static let preferredHeight: CGFloat = 60
    
    
    // MARK: Subviews
    
    /// Content stack view.
    private let stackView: UIStackView = UIStackView(frame: .zero)
    
    /// Title label.
    public let titleLabel: UILabel = UILabel(frame: .zero)
    
    /// Slider.
    public let slider: BaseSlider = BaseSlider(frame: .zero)
    
    
    // MARK: Lifecycle
    
    public override func setupSubviewHierarchy() {
        
        super.setupSubviewHierarchy()
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(slider)
        
    }
    
    public override func setupSubviewConstraints() {
        
        super.setupSubviewConstraints()
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        
        slider.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        
    }
    
    public override func setupSubviews() {
        
        super.setupSubviews()
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        
        titleLabel.font = .primary(ofSize: 18, .bold)
        titleLabel.textColor = Asset.Colors.darkGray.color
        
    }
    
}
