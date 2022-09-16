//
//  ShutterSettingsView.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 16.09.2022.
//

import UIKit
import SnapKit


// MARK: - View

/// Content view of the roller shutter settings screen.
public final class ShutterSettingsView: BaseView {
    
    
    // MARK: Subviews
    
    /// Custom navigation bar that is a part of the view.
    @AutoLayout public var navigationView: NavigationBarView = NavigationBarView(frame: .zero)
    
    /// Device description view.
    @AutoLayout public var deviceInfoView: DeviceInfoView = DeviceInfoView(frame: .zero)
    
    /// Roller shutter position slider.
    @AutoLayout public var intensitySlider: LabeledHorizontalSlider = LabeledHorizontalSlider(frame: .zero)
    
    
    // MARK: Lifecycle
    
    public override func setupSubviewHierarchy() {
        super.setupSubviewHierarchy()
        addSubview(navigationView)
        addSubview(deviceInfoView)
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
        
        intensitySlider.snp.makeConstraints { make in
            make.top.equalTo(deviceInfoView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(LabeledHorizontalSlider.preferredHeight)
        }
        
    }
    
    public override func setupSubviewBindings() {
        super.setupSubviewBindings()
    }
    
    public override func setupSubviews() {
        
        super.setupSubviews()
        
        navigationView.titleLabel.text = "Device settings"
        
        deviceInfoView.deviceTypeLabel.text = "Roller shutter"
        
        intensitySlider.slider.minimumValue = 0
        intensitySlider.slider.maximumValue = 100
        intensitySlider.slider.tintColor = Asset.Colors.lightSteelBlue.color
        
    }
    
}


#if DEBUG
import SwiftUI


struct ShutterSettingsView_Preview: PreviewProvider {
    
    static var previews: some View {
        
        UIViewPreview {
            let view = ShutterSettingsView(frame: .zero)
            return view
        }
        .border(Color.blue, width: 0.6)
        
    }
    
}
#endif
