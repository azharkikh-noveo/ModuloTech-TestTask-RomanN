//
//  HeaterSettingsViewController.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


// MARK: - Screen

/// The heater device editor screen.
public final class HeaterSettingsViewController: BaseViewController {
    
    
    /// The view-model.
    private let viewModel: HeaterSettingsViewModel
    
    
    // MARK: Subviews
    
    /// Use this property instead of just `view`. Casts a view controller `view` to the needed class.
    private var settingsView: HeaterSettingsView! {
        return view as? HeaterSettingsView
    }
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of view controller and assignes a view-model to it.
    public init(viewModel: HeaterSettingsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = HeaterSettingsView(frame: .zero)
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
                .sink(receiveValue: viewModel.setHeaterMode(isOn:))
            
            settingsView
                .temperatureSlider
                .slider
                .valueChanged
                .map(\.valueConsideringStep)
                .map(Double.init)
                .removeDuplicates()
                .sink(receiveValue: viewModel.setTemperature(_:))
            
        }
        
        
        // View-model subscriptions
        
        disposeBag.collect {
            
            viewModel
                .isHeaterOn
                .map { isOn -> String in
                    if isOn {
                        return L10n.DeviceSettings.Heater.Mode.on
                    } else {
                        return L10n.DeviceSettings.Heater.Mode.off
                    }
                }
                .receive(on: DispatchQueue.main)
                .assign(
                    to: \.text,
                    on: settingsView.modeSwitchView.titleLabel
                )
            
            viewModel
                .heaterTemperature
                .map { String(format: "%.1f", $0) }
                .map { L10n.DeviceSettings.Heater.Slider.title($0) }
                .receive(on: DispatchQueue.main)
                .assign(
                    to: \.text,
                    on: settingsView.temperatureSlider.titleLabel
                )
            
        }
        
    }
    
}
