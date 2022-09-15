//
//  DeviceListViewController.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit


// MARK: - Screen

/// Device list a.k.a home screen of the app.
public final class DeviceListViewController: BaseViewController {
    
    
    /// The viewmodel.
    private let viewModel: DeviceListViewModel
    
    
    // MARK: Subviews
    
    /// Use this property instead of just `view`. Casts a view controller `view` to the needed class.
    private var deviceListView: DeviceListView! {
        return view as? DeviceListView
    }
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of view controller and assignes a view-model to it.
    public init(viewModel: DeviceListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = DeviceListView(frame: .zero)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        deviceListView.tableView.dataSource = self
        deviceListView.tableView.delegate = self
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
        
        viewModel.devices
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                deviceListView.tableView.reloadData()
            }
            .store(in: &disposeBag)
        
    }
    
}


// MARK: UITableViewDataSource

extension DeviceListViewController: UITableViewDataSource {
    
    
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.devices.value.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell: DeviceListTableViewCell = tableView.dequeue(for: indexPath)
        cell.assign(viewModel.devices.value[indexPath.row])
        return cell
    }
    
}


// MARK: UITableViewDelegate

extension DeviceListViewController: UITableViewDelegate {
    
    
    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let device: Device = viewModel.devices.value[indexPath.row]
        viewModel.openSettingsScreen(for: device)
    }
    
}
