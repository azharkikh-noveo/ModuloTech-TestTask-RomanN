//
//  LightSettingsView.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit
import SnapKit


// MARK: - View

/// Content view of the light settings screen.
public final class LightSettingsView: BaseView {
    
    
    // MARK: Subviews
    
    /// Custom navigation bar that is a part of the view.
    @AutoLayout public var navigationView: NavigationBarView = NavigationBarView(frame: .zero)
    
    /// Light mode switch view.
    @AutoLayout public var modeSwitchView: ModeSwitchView = ModeSwitchView(frame: .zero)
    
    /// Slider to configure the light intensity.
    @AutoLayout public var intensitySlider: BaseSlider = BaseSlider(frame: .zero)
    
    
    // MARK: Lifecycle
    
    public override func setupSubviewHierarchy() {
        super.setupSubviewHierarchy()
        addSubview(navigationView)
        addSubview(modeSwitchView)
        addSubview(intensitySlider)
    }
    
    public override func setupSubviewConstraints() {
        
        super.setupSubviewConstraints()
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(NavigationBarView.preferredHeight)
        }
        
        modeSwitchView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(ModeSwitchView.preferredHeight)
        }
        
        intensitySlider.snp.makeConstraints { make in
            make.top.equalTo(modeSwitchView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        
    }
    
    public override func setupSubviewBindings() {
        super.setupSubviewBindings()
    }
    
    public override func setupSubviews() {
        
        super.setupSubviews()
        
        navigationView.titleLabel.text = "Device settings"
        
        intensitySlider.minimumValue = 0
        intensitySlider.maximumValue = 100
        intensitySlider.tintColor = Asset.Colors.lightSteelBlue.color
        
    }
    
}


#if DEBUG
import SwiftUI


struct LightSettingsView_Preview: PreviewProvider {
    
    static var previews: some View {
        
        UIViewPreview {
            let view = LightSettingsView(frame: .zero)
            view.modeSwitchView.switchView.isOn = true
            view.modeSwitchView.titleLabel.text = "Light is on"
            return view
        }
        .border(Color.blue, width: 0.6)
        
    }
    
}
#endif
