//
//  ShutterSettingsViewController.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 16.09.2022.
//

import UIKit


// MARK: - Screen

/// The roller shutter device editor screen.
public final class ShutterSettingsViewController: BaseViewController {
    
    
    /// The view-model.
    private let viewModel: ShutterSettingsViewModel
    
    
    // MARK: Subviews
    
    /// Use this property instead of just `view`. Casts a view controller `view` to the needed class.
    private var settingsView: ShutterSettingsView! {
        return view as? ShutterSettingsView
    }
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of view controller and assignes a view-model to it.
    public init(viewModel: ShutterSettingsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = ShutterSettingsView(frame: .zero)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        settingsView.deviceInfoView.deviceTitleLabel.text = viewModel.device.name
        settingsView.deviceInfoView.deviceTypeLabel.text = L10n.Device.RollerShutter.kind
        settingsView.positionSlider.slider.set(value: viewModel.device.position)
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
            .positionSlider
            .slider
            .valueChanged
            .map(\.valueConsideringStep)
            .map(Int.init)
            .removeDuplicates()
            .sink(receiveValue: viewModel.setPosition(_:))
            .store(in: &disposeBag)
        
        
        // View-model subscriptions

        viewModel
            .shutterPosition
            .map { position in
                if position == 0 {
                    return L10n.DeviceSettings.RollerShutter.Slider.Title.closed
                } else if position == 100 {
                    return L10n.DeviceSettings.RollerShutter.Slider.Title.opened
                } else {
                    return L10n.DeviceSettings.RollerShutter.Slider.Title.openedAt(position)
                }
            }
            .receive(on: DispatchQueue.main)
            .assign(
                to: \.text,
                on: settingsView.positionSlider.titleLabel
            )
            .store(in: &disposeBag)
        
    }
    
}
