//
//  LightSettingsView.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit
import SnapKit


// MARK: - View

/// Content view of the light settings screen.
public final class LightSettingsView: BaseView {
    
    
    // MARK: Subviews
    
    /// Custom navigation bar that is a part of the view.
    @AutoLayout public var navigationView: NavigationBarView = NavigationBarView(frame: .zero)
    
    /// Light description view.
    @AutoLayout public var deviceInfoView: DeviceInfoView = DeviceInfoView(frame: .zero)
    
    /// Light mode switch view.
    @AutoLayout public var modeSwitchView: ModeSwitchView = ModeSwitchView(frame: .zero)
    
    /// Slider to configure the light intensity.
    @AutoLayout public var intensitySlider: LabeledHorizontalSlider = LabeledHorizontalSlider(frame: .zero)
    
    
    // MARK: Lifecycle
    
    public override func setupSubviewHierarchy() {
        super.setupSubviewHierarchy()
        addSubview(navigationView)
        addSubview(deviceInfoView)
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
        
        deviceInfoView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(60)
            make.height.equalTo(DeviceInfoView.preferredHeight)
        }
        
        modeSwitchView.snp.makeConstraints { make in
            make.top.equalTo(deviceInfoView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(ModeSwitchView.preferredHeight)
        }
        
        intensitySlider.snp.makeConstraints { make in
            make.top.equalTo(modeSwitchView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(LabeledHorizontalSlider.preferredHeight)
        }
        
    }
    
    public override func setupSubviewBindings() {
        super.setupSubviewBindings()
    }
    
    public override func setupSubviews() {
        
        super.setupSubviews()
        
        navigationView.titleLabel.text = L10n.DeviceSettings.NavigationBar.title
        
        deviceInfoView.deviceTypeLabel.text = L10n.Device.Light.kind
        
        intensitySlider.slider.minimumValue = 0
        intensitySlider.slider.maximumValue = 100
        intensitySlider.slider.tintColor = Asset.Colors.lightSteelBlue.color
        
    }
    
}
