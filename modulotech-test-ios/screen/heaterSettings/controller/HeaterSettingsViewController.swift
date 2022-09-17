//
//  HeaterSettingsViewController.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 16.09.2022.
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
        settingsView.deviceInfoView.deviceTitleLabel.text = viewModel.device.name
        settingsView.deviceInfoView.deviceTypeLabel.text = "Heater"
        settingsView.modeSwitchView.switchView.isOn = viewModel.device.mode.booleanValue
        settingsView.temperatureSlider.slider.set(value: viewModel.device.temperature)
        viewModel.onViewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onViewWillAppear()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.onViewWillDisappear()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.onViewDidDisappear()
    }
    
    
    // MARK: Helper
    
    /// Setups bindings to the view. Should be called once.
    private func setupBindings() {
        
        // View subscriptions
        
        settingsView
            .navigationView
            .backButton
            .publisher(for: .touchUpInside)
            .sink { [unowned self] _ in
                viewModel.close()
            }
            .store(in: &disposeBag)
        
        settingsView
            .modeSwitchView
            .switchView
            .publisher(for: .touchUpInside)
            .map(\.isOn)
            .removeDuplicates()
            .sink(receiveValue: viewModel.setHeaterMode(isOn:))
            .store(in: &disposeBag)
        
        settingsView
            .temperatureSlider
            .slider
            .valueChanged
            .map(\.valueConsideringStep)
            .map(Double.init)
            .removeDuplicates()
            .sink(receiveValue: viewModel.setTemperature(_:))
            .store(in: &disposeBag)
        
        
        // View-model subscriptions
        
        viewModel
            .isHeaterOn
            .map { "Selected mode \"" + ($0 ? "ON" : "OFF") + "\"" }
            .receive(on: DispatchQueue.main)
            .assign(
                to: \.text,
                on: settingsView.modeSwitchView.titleLabel
            )
            .store(in: &disposeBag)
        
        viewModel
            .heaterTemperature
            .map(Float.init)
            .map { "Temperature: \(String(format: "%.1f", $0)) °C" }
            .receive(on: DispatchQueue.main)
            .assign(
                to: \.text,
                on: settingsView.temperatureSlider.titleLabel
            )
            .store(in: &disposeBag)
        
    }
    
}