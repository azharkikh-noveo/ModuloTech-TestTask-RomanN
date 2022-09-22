//
//  LightSettingsViewController.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


// MARK: - Screen

/// The light device editor screen.
public final class LightSettingsViewController: BaseViewController {
    
    
    /// The view-model.
    private let viewModel: LightSettingsViewModel
    
    
    // MARK: Subviews
    
    /// Use this property instead of just `view`. Casts a view controller `view` to the needed class.
    private var settingsView: LightSettingsView! {
        return view as? LightSettingsView
    }
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of view controller and assignes a view-model to it.
    public init(viewModel: LightSettingsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = LightSettingsView(frame: .zero)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        settingsView.setup(for: viewModel.device)
        viewModel.initialSetup()
    }
    
    
    // MARK: Helper
    
    /// Setups bindings to the view. Should be called once.
    private func setupBindings() {
        
        // View subscriptions
        
        disposeBag.collect {
            
            settingsView
                .navigationView
                .backButton
                .publisher(for: .touchUpInside)
                .sink { [unowned self] _ in
                    viewModel.close()
                }
            
            settingsView
                .modeSwitchView
                .switchView
                .publisher(for: .touchUpInside)
                .map(\.isOn)
                .removeDuplicates()
                .sink(receiveValue: viewModel.setLightMode(isOn:))
            
            settingsView
                .intensitySlider
                .slider
                .valueChanged
                .map(\.valueConsideringStep)
                .map(Int.init)
                .removeDuplicates()
                .sink(receiveValue: viewModel.setIntensity(_:))
            
        }
        
        
        // View-model subscriptions
        
        disposeBag.collect {
            
            viewModel
                .isLightOn
                .map { isOn -> String in
                    if isOn {
                        return L10n.DeviceSettings.Light.Mode.on
                    } else {
                        return L10n.DeviceSettings.Light.Mode.off
                    }
                }
                .receive(on: DispatchQueue.main)
                .assign(
                    to: \.text,
                    on: settingsView.modeSwitchView.titleLabel
                )
            
            viewModel
                .lightIntensity
                .map { L10n.DeviceSettings.Light.Slider.title($0) }
                .receive(on: DispatchQueue.main)
                .assign(
                    to: \.text,
                    on: settingsView.intensitySlider.titleLabel
                )
            
        }
        
    }
    
}
