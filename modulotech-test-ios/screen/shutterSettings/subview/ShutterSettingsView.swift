//
//  ShutterSettingsView.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit
import SnapKit


// MARK: - View

/// Content view of the roller shutter settings screen.
public final class RollerShutterSettingsView: BaseView {
    
    
    // MARK: Subviews
    
    /// Custom navigation bar that is a part of the view.
    public let navigationView: NavigationBarView = NavigationBarView(frame: .zero)
    
    /// Device description view.
    public let deviceInfoView: DeviceInfoView = DeviceInfoView(frame: .zero)
    
    /// Roller shutter position slider.
    public let positionSlider = LabeledVerticalSlider(frame: .zero)
    
    
    // MARK: Lifecycle
    
    public override func setupSubviewHierarchy() {
        super.setupSubviewHierarchy()
        addSubview(navigationView)
        addSubview(deviceInfoView)
        addSubview(positionSlider)
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
        
        positionSlider.snp.makeConstraints { make in
            make.top.equalTo(deviceInfoView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(30)
        }
        
    }
    
    public override func setupSubviews() {
        
        super.setupSubviews()
        
        navigationView.titleLabel.text = L10n.DeviceSettings.NavigationBar.title
        
        positionSlider.slider.tintColor = Asset.Colors.lightSteelBlue.color
        
    }
    
    
    // MARK: Helper
    
    /// Setups a view for the device. Should be called once.
    public func setup(for device: RollerShutter) {
        
        deviceInfoView.deviceTypeLabel.text = device.deviceType.stringValue
        deviceInfoView.deviceTitleLabel.text = device.name
        
        positionSlider.slider.minimumValue = Float(device.minimumPosition)
        positionSlider.slider.maximumValue = Float(device.maximumPosition)
        positionSlider.slider.set(value: device.position)
        
    }
    
}
