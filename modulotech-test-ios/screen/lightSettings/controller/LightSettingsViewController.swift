//
//  LightSettingsViewController.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
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
            .sink(receiveValue: viewModel.setLightMode(isOn:))
            .store(in: &disposeBag)
        
        
        // View-model subscriptions
        
        viewModel
            .isLightOn
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] isOn in
                settingsView.modeSwitchView.switchView.isOn = isOn
                settingsView.modeSwitchView.titleLabel.text = "Selected mode \"" + (isOn ? "ON" : "OFF") + "\""
            }
            .store(in: &disposeBag)
        
    }
    
}
