//
//  RollerShutterSettingsViewController.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


// MARK: - Screen

/// The roller shutter device editor screen.
public final class RollerShutterSettingsViewController: BaseViewController {
    
    
    /// The view-model.
    private let viewModel: RollerShutterSettingsViewModel
    
    
    // MARK: Subviews
    
    /// Use this property instead of just `view`. Casts a view controller `view` to the needed class.
    private var settingsView: RollerShutterSettingsView! {
        return view as? RollerShutterSettingsView
    }
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of view controller and assignes a view-model to it.
    public init(viewModel: RollerShutterSettingsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = RollerShutterSettingsView(frame: .zero)
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
                .positionSlider
                .slider
                .valueChanged
                .map(\.valueConsideringStep)
                .map(Int.init)
                .removeDuplicates()
                .sink(receiveValue: viewModel.setPosition(_:))
            
        }
        
        
        // View-model subscriptions

        disposeBag.collect {
            
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
            
        }
        
    }
    
}
